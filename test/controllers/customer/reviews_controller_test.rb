require "test_helper"

class Customer::ReviewsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @customer = customers(:customer_one)
    @product = products(:product_one)
    @review = reviews(:review_one)
    sign_in @customer
  end
  
  
  test "should get products" do
    sign_in @customer
    get products_url
    # puts @product.id
    # puts @customer.id
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_product_review_url(@product, @review)
  #   assert_response :success
  # end
end
