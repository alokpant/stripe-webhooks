# test/controllers/billings_controller_test.rb

require 'test_helper'
require 'ostruct'

class BillingsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)  # Assuming you have a user fixture
    sign_in @user
  end

  # test 'should redirect to billing portal session URL' do
  #   session_stub = OpenStruct.new(url: 'https://billing-portal-url')
  #   Stripe::BillingPortal::Session.stub(:create, session_stub) do
  #     get portal_billings_url
  #     assert_response :redirect
  #     assert_redirected_to 'https://billing-portal-url'
  #   end
  # end

  # test 'should create a billing portal session for the current user' do
  #   session_stub = OpenStruct.new(url: 'https://billing-portal-url')
  #   Stripe::BillingPortal::Session.stub(:create, session_stub) do
  #     get portal_billings_url
  #     assert_response :redirect
  #   end

  #   assert_requested(:post, 'https://api.stripe.com/v1/billing_portal/sessions', times: 1) do |req|
  #     json_body = JSON.parse(req.body)
  #     assert_equal @user.stripe_customer_id, json_body['customer']
  #     assert_equal subscriptions_url, json_body['return_url']
  #   end
  # end

  # test 'should allow other hosts in the redirect' do
  #   session_stub = OpenStruct.new(url: 'https://billing-portal-url')
  #   Stripe::BillingPortal::Session.stub(:create, session_stub) do
  #     get portal_billings_url
  #     assert_response :redirect
  #   end

  #   assert_equal '*', @response.headers['Access-Control-Allow-Origin']
  # end

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
