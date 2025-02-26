class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable, :confirmable
  with_options presence: true do
    validates :name
    validates :status
  end
  enum status: {
    normal: 0,
    withdrawn: 1,
    banned: 2
  }
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reviewed_products, through: :reviews, source: :product, dependent: :destroy

  def line_items_checkout
    cart_items.map do |cart_item|
      {
        quantity: cart_item.quantity,
        price_data: {
          currency: 'jpy',
          unit_amount: cart_item.product.price,
          product_data: {
            name: cart_item.product.name,
            metadata: {
              product_id: cart_item.product_id
            }
          }
        }
      }
    end
  end

  def active_for_authentication?
    super && (status == 'normal')
  end
end
