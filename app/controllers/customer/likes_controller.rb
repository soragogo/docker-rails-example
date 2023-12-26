class Customer::LikesController < ApplicationController
  def index
    @products, @sort = get_likes(params)
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
    return @products.all, 'default' unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high]

    return @products.latest, 'latest' if params[:latest]

    return @products.price_high_to_low, 'price_high_to_low' if params[:price_high_to_low]

    [@products.price_low_to_high, 'price_low_to_high'] if params[:price_low_to_high]
  end
end

