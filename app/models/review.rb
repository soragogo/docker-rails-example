class Review < ApplicationRecord
  belongs_to :product
  belongs_to :customer

  validates :customer_id, uniqueness: { scope: :product_id }
  validates :star, presence: true, inclusion: {in: ["1" ,"2" ,"3" ,"4" ,"5"]}
  validates :comment, length: { maximum: 500 }
end
