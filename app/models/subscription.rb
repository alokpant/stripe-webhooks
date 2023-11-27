class Subscription < ApplicationRecord
  enum :status, { unpaid: 'unpaid', paid: 'paid', canceled: 'canceled'}, default: :unpaid

  STRIPE_LOOKUP_KEYS = %w[monthly_one_off yearly_one_off monthly_recurring yearly_recurring].freeze
  SUBSCRIPTION_BUTTON_COLORS = {
    unpaid: 'orange',
    paid: 'green',
    canceled: 'yellow'
  }.freeze

  validates_presence_of :stripe_id, :status
end
