class Customer::ProductsController < ApplicationController
  helper_method :product_liked?


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
  end

  def show
    @product = Product.find_by(id: params[:id])

    if @product.nil?
      redirect_to products_path, flash: { error: 'Product could not be found' }
    elsif !current_customer.nil?
      @cart_item = CartItem.new
      @like = Like.find_by(customer_id: current_customer.id, product_id: @product.id)
    end
  end

  
  private

  def product_liked?
    unless @product.likes.find_by(customer_id: current_customer).nil?
      true
    else
      false
    end
  end
  
  def get_products(params)
    return Product.all, 'default' unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high]

    return Product.latest, 'latest' if params[:latest]

    return Product.price_high_to_low, 'price_high_to_low' if params[:price_high_to_low]

    [Product.price_low_to_high, 'price_low_to_high'] if params[:price_low_to_high]
  end

  
end

