class Customer::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: %i[increase decrease destroy]

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.line_total }
  end

  def create
    product_id = params.dig(:cart_item, :product_id)
    cart_item = current_customer.cart_items.find_by(product_id: product_id)
  
    if cart_item && cart_item.quantity >= Product.find_by(id: product_id).stock
      redirect_to request.referer, alert: 'Not enough stock available'
    else
      increase_or_create(params[:cart_item][:product_id])
    end
  end
  
  def increase
    product = @cart_item.product
    if product.stock >= (@cart_item.quantity + 1)
      @cart_item.increment!(:quantity, 1)
      redirect_to request.referer, notice: 'Successfully updated your cart'
    else
      redirect_to request.referer, alert: 'Not enough stock available'
    end
  end
  
  def decrease
    decrease_or_destroy(@cart_item)
    redirect_to request.referer, notice: 'Successfully updated your cart'
  end
  
  def destroy
    @cart_item.destroy
    redirect_to request.referer, notice: 'Successfully deleted one cart item'
  end
  
  private
  
  def set_cart_item
    @cart_item = current_customer.cart_items.find(params[:id])
  end

  def increase_or_create(product_id)
    product = Product.find_by(id: product_id)
    cart_item = current_customer.cart_items.find_by(product_id: product_id)
    
    if product && product.stock > 0
      if cart_item
        if product.stock > cart_item.quantity
          cart_item.increment!(:quantity, 1)
          redirect_to cart_items_path, notice: 'Successfully added product to your cart'
        else
          redirect_to request.referer, alert: 'Not enough stock available'
        end
      else
        current_customer.cart_items.create(product_id: product_id, quantity: 1)
      end
    else
      redirect_to request.referer, alert: 'Product is not available'
    end
  end
  
  
  def decrease_or_destroy(cart_item)
    if cart_item.quantity > 1
      cart_item.decrement!(:quantity, 1)
    else
      cart_item.destroy
    end
  end
end
