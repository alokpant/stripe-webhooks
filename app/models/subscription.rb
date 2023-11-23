class Subscription < ApplicationRecord
  enum :status, { unpaid: 'unpaid', paid: 'paid', cancelled: 'cancelled'}, default: :unpaid

  validates :stripe_id, presence: true
end
