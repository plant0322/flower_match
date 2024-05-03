require "test_helper"

class Shop::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get shop_members_show_url
    assert_response :success
  end
end
