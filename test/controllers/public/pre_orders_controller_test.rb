require "test_helper"

class Public::PreOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_pre_orders_new_url
    assert_response :success
  end

  test "should get confirm" do
    get public_pre_orders_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get public_pre_orders_thanks_url
    assert_response :success
  end

  test "should get index" do
    get public_pre_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get public_pre_orders_show_url
    assert_response :success
  end
end
