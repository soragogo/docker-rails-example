class Customer::LikesController < ApplicationController
  before_action :authenticate_customer!
  def index
    @categories = Product.categories.values
    @products, @sort = get_likes(params)
    @selected_category = params[:category]

    if @selected_category && @selected_category != "0"
      @products = @products.where(category: @selected_category)
    end
  end

  def create
    @like = Like.new(customer_id: current_customer.id, product_id: params[:product_id])
    @like.save
    redirect_to request.referer || root_path
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    if @like
      @like.destroy
    end
    redirect_to request.referer || root_path
  end

  def show
   
  end

  private

  def get_likes(params)
    @products = current_customer.liked_products
    return @products.all, 'default' unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high] || params[:average_star_high_to_low] || params[:average_star_low_to_high]
    return @products.latest, 'latest' if params[:latest]
    return @products.price_high_to_low, 'price_high_to_low' if params[:price_high_to_low]
    return @products.price_low_to_high, 'price_low_to_high' if params[:price_low_to_high]
    return @products.all, 'average_star_high_to_low' if params[:average_star_high_to_low]
    return @products.all, 'average_star_low_to_high' if params[:average_star_low_to_high]

  end
end

