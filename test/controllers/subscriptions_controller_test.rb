# test/controllers/subscriptions_controller_test.rb

require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:one)
    @subscription = subscriptions(:unpaid_subscription)
    sign_in @user
  end

  test 'should get index' do
    get subscriptions_url
    assert_response :success
    assert_not_nil assigns(:user)
    assert_not_nil assigns(:prices)
    assert_not_nil assigns(:subscriptions)
  end

  test 'should get success' do
    get subscription_success_url
    assert_response :redirect
    assert_redirected_to subscriptions_url
    assert_equal 'Your subscription was created successfully', flash[:notice]
  end

  test 'should get failure' do
    get subscription_failure_url
    assert_response :redirect
    assert_redirected_to subscriptions_url
    assert_equal 'There was some problem with your subscription', flash[:alert]
  end

  private

  def sign_in(user)
    post user_session_url, params: {
      user: {
        email: user.email,
        password: 'password'
      }
    }
  end
end
