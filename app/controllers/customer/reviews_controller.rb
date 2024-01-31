class Customer::ReviewsController < ApplicationController
  before_action :authenticate_customer!
  before_action :has_bought?
  
  def new
    @review = Review.new
    unless (Review.where(customer_id: current_customer.id, product_id: params[:product_id]).first.nil?)
      redirect_to product_path(params[:product_id]), notice: 'Your review already exists.'
    else
      puts current_customer.id
      puts params[:product_id] 
    end
  end

  def create
      @review = Review.new(review_params)
      @review.customer_id = current_customer.id
      if @review.save
        redirect_to product_path(@review.product), notice: 'Review was successfully created.'
      else
        render :new
      end
  end

  def edit
    @review = Review.find_by(id: params[:id])
  end
  
  def update
    @review = Review.find_by(id: params[:id])
    @review.star = params[:review][:star]
    @review.comment = params[:review][:comment]
    if @review.save
      redirect_to product_path(@review.product), notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find_by(id: params[:id])
    if @review && @review.destroy
      redirect_to request.referer, notice: 'Successfully deleted your review'
    end
  end

    private
    def review_params
        params.require(:review).permit(:star, :comment, :product_id)
    end

    def has_bought?
      product_id = params[:product_id] || params[:review][:product_id]
      product = Product.find_by(id: product_id)
      unless product && current_customer.orders.joins(:order_details).where(order_details: { product_id: product.id }).exists?
        redirect_to request.referer || root_path, alert: 'You must purchase the product before reviewing.'
      end
    end

end
