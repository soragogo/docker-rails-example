require "test_helper"

class Customer::ReviewsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get new" do
    product = FactoryBot.create(:product)
    get new_product_review_url(product)
    assert_response :success
  end
end
