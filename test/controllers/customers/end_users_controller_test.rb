require 'test_helper'

class Customers::EndUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get customers_end_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get customers_end_users_edit_url
    assert_response :success
  end

  test "should get confirm" do
    get customers_end_users_confirm_url
    assert_response :success
  end

end
