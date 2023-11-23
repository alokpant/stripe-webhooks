require "test_helper"

class SubscriptionTest < ActiveSupport::TestCase
  test 'presence of attributes' do
    subscription = Subscription.new

    assert_not subscription.valid?
    assert_includes subscription.errors[:stripe_id], "can't be blank"
    assert_equal subscription.status, 'unpaid'
  end

  test 'default values' do
    stripe_id = 'stripe_id'
    subscription = Subscription.create(stripe_id:)
    assert_equal 'unpaid', subscription.status
    assert_equal 'stripe_id', subscription.stripe_id
  end

  test 'submitted values' do
    stripe_id = 'stripe_id'
    subscription = Subscription.create(stripe_id:, status: 'paid')
    assert_equal 'paid', subscription.status
  end
end
