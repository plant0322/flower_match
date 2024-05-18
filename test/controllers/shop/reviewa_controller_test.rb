require "test_helper"

class Shop::ReviewaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shop_reviewa_index_url
    assert_response :success
  end
end
