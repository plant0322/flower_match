require "test_helper"

class Public::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get mypage" do
    get public_members_mypage_url
    assert_response :success
  end

  test "should get edit" do
    get public_members_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get public_members_unsubscribe_url
    assert_response :success
  end
end
