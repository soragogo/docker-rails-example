class Review < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  validates :customer_id, uniqueness: { scope: :product_id }
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, length: { maximum: 500 }
end
