require "test_helper"

class Shop::ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get shop_items_new_url
    assert_response :success
  end

  test "should get index" do
    get shop_items_index_url
    assert_response :success
  end

  test "should get show" do
    get shop_items_show_url
    assert_response :success
  end

  test "should get edit" do
    get shop_items_edit_url
    assert_response :success
  end
end
