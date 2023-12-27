class Product < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :price, numericality: { greater_than: 0 }
    validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :image
  end

  
  validate :image_type

  has_one_attached :image

  enum category:{
    outer: 0,
    tops: 1,
    shirt: 2,
    pants: 3,
    skirt: 4,
    dresses: 5,
    goods: 6, 
    accessory: 7,
    bags: 8, 
    shoes: 9
  }

  private

  def image_type
    return unless image.attached? && !image.content_type.in?(%('image/jpeg image/png image/gif'))

    errors.add(:image, 'must be a JPEG, PNG, or GIF')
  end
  has_one_attached :image
  scope :price_high_to_low, -> { order(price: :desc) }
  scope :price_low_to_high, -> { order(price: :asc) }
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_customers, through: :likes, source: :customer, dependent: :destroy
end
