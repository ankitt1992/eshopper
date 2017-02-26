require 'test_helper'

class ReportControllerTest < ActionController::TestCase
  test "should get order_report" do
    get :order_report
    assert_response :success
  end

  test "should get coupon_report" do
    get :coupon_report
    assert_response :success
  end

  test "should get user_report" do
    get :user_report
    assert_response :success
  end

end
