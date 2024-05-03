require "test_helper"

class Shop::PreOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shop_pre_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get shop_pre_orders_show_url
    assert_response :success
  end

  test "should get user_pre_orders" do
    get shop_pre_orders_user_pre_orders_url
    assert_response :success
  end
end
