class Subscription < ApplicationRecord
  enum :status, { unpaid: 'unpaid', paid: 'paid', cancelled: 'cancelled'}, default: :unpaid

  validates_presence_of :stripe_id, :status
end
