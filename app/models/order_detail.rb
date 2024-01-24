class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  def customer_id
    order.customer_id
  end
end
