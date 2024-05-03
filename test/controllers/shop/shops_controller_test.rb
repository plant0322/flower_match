require "test_helper"

class Shop::ShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get shop_shops_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get shop_shops_unsubscribe_url
    assert_response :success
  end
end
