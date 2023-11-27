class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def to_s
    email
  end

  after_create do
    customer = Stripe::Customer.create(email: email)
    plan = Stripe::Plan.list
    ActiveRecord::Base.transaction do
      subscription = Stripe::Subscription.create(
        customer: customer.id,
        items: [{
          price: plan.first.id,
        }],
        payment_behavior: 'default_incomplete',
        expand: ['latest_invoice.payment_intent']
      )
      Stripe::Invoice.create({
        customer: subscription.customer.id,
        subscription: subscription.id
      })
    end
  end
end
