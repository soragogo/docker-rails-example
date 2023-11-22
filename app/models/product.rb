class Product < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :price, numericality: { greater_than: 0}
    validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0}
    validates :image
  end

  validate :image_type

  has_one_attached :image
  private

  def image_type
    if image.attached? && !image.content_type.in?(%('image/jpeg image/png image/gif'))
        errors.add(:image, 'must be a JPEG, PNG, or GIF')
    end
end
  has_one_attached :image
  scope :price_high_to_low, -> { order(price: :desc) }
  scope :price_low_to_high, -> { order(price: :asc) }

end
