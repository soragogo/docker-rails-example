class Customer::ProductsController < ApplicationController
  helper_method :product_liked?
  before_action :check_customer_or_admin, only: [:show]

  def index
    @categories = Product.categories.values
    @selected_category = params[:category] == "" ? "0" : params[:category]
    @products, @sort = get_products(params)

    if @selected_category && @selected_category != "0"
      @products = @products.where(category: @selected_category)
    end

    if params[:search]
      @products = @products.where("name LIKE ?", "%#{params[:search]}%")
    end

    if params[:average_star_low_to_high]
      @products = @products.sort_by { |product| product.average_star }
    end
    if params[:average_star_high_to_low]
      @products = @products.sort_by { |product| -product.average_star }
    end
  end

  def show
    @product = Product.find_by(id: params[:id])
    if @product.nil?
      redirect_to products_path, flash: { error: 'Product could not be found' }
    elsif !current_customer.nil?
      @review = Review.find_by(customer_id: current_customer.id, product_id: @product.id)
      @cart_item = CartItem.new
      @like = Like.find_by(customer_id: current_customer.id, product_id: @product.id)
    end
  end

  private

  def check_customer_or_admin
    if current_customer.nil? && current_admin.nil?
      redirect_to new_customer_session_path,  notice: 'You have to sign in or sign up before continuing.'
    elsif current_customer.nil?
      @product = Product.find_by(id: params[:id])
        if @product.nil?
          redirect_to products_path, flash: { error: 'Product could not be found' }
        else
          redirect_to admin_product_path(@product)
        end
    end
  end

  def product_liked?
    unless @product.likes.find_by(customer_id: current_customer).nil?
      true
    else
      false
    end
  end
  
  def get_products(params)
    return Product.all, 'default' unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high] || params[:average_star_high_to_low] || params[:average_star_low_to_high]
    return Product.latest, 'latest' if params[:latest]
    return Product.price_high_to_low, 'price_high_to_low' if params[:price_high_to_low]
    return Product.price_low_to_high, 'price_low_to_high' if params[:price_low_to_high]
    return Product.all, 'average_star_high_to_low' if params[:average_star_high_to_low]
    return Product.all, 'average_star_low_to_high' if params[:average_star_low_to_high]
  end
end
