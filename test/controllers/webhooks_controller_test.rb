require 'test_helper'
require 'stripe_mock'

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  def setup
    super
    StripeMock.start
  end

  def teardown
    super
    StripeMock.stop
  end

  # test 'should test stripe webhook' do
  #   # Mock the webhook event
  #   event = StripeMock.mock_webhook_event('customer.subscription.created', {
  #     data: {
  #       object: {
  #         id: 'sub_1OGpXuANY0SySqu43vcXP0Dm',
  #         status: 'active',
  #         customer: 'cus_P4zWlUGyxz2S7r'
  #       }
  #     }
  #   })

  #   # Replace 'your_webhook_secret' with your actual webhook signing secret
  #   webhook_secret = Rails.application.credentials.stripe[:signing_secret]

  #   # Generate a valid signature
  #   timestamp = Time.now.to_i
  #   payload_string = "#{timestamp}.#{event.to_json}"
  #   signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), webhook_secret, payload_string)

  #   # Include the signature and timestamp in the request headers
  #   post webhooks_stripe_url, params: event.to_json,
  #       headers: { 'HTTP_STRIPE_SIGNATURE' => "#{timestamp}.#{signature}" }

  #   assert_response :success
  # end

  # test 'should handle subscription creation event' do
  #   event = StripeMock.mock_webhook_event(
  #     'customer.subscription.created',
  #     data: {
  #       object: { subscription: 'stripe_subscription_id_1' }
  #     }
  #   )
  #   post webhooks_stripe_url

  #   assert_equal 'paid', subscription.reload.status
  # end

  # test 'should handle subscription creation event for existing subscription' do
  #   event = StripeMock.mock_webhook_event('customer.subscription.created',  data: { object: { id: 'stripe_subscription_id_1' } })

  #   assert_difference('Subscription.count', 1) do
  #     post webhooks_stripe_url, params: { id: 'stripe_subscription_id_1' }
  #   end
  # end

  # test 'should handle payment succeeded event' do
  #   subscription = Subscription.where(status: 'unpaid', stripe_id: 'stripe_subscription_id_1').first

  #   event = StripeMock.mock_webhook_event(
  #     'invoice.payment_succeeded',
  #     data: {
  #       object: { subscription: 'stripe_subscription_id_1' }
  #     }
  #   )
  #   post webhooks_stripe_url

  #   assert_equal 'paid', subscription.reload.status
  # end

  # test 'should handle subscription deleted event' do
  #   subscription = Subscription.where(status: 'unpaid', stripe_id: 'stripe_subscription_id_1').first

  #   event = StripeMock.mock_webhook_event('customer.subscription.deleted',
  #     data: { object: { id: 'stripe_subscription_id_1' } })
  #   post webhooks_stripe_url

  #   assert_equal 'canceled', subscription.reload.status
  # end
end
