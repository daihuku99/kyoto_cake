require 'test_helper'

class Customers::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customers_orders_index_url
    assert_response :success
  end

  test "should get new" do
    get customers_orders_new_url
    assert_response :success
  end

  test "should get confirm" do
    get customers_orders_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get customers_orders_thanks_url
    assert_response :success
  end

  test "should get show" do
    get customers_orders_show_url
    assert_response :success
  end

end
