class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    # @plans = Stripe::Plan.list.data
    @prices = stripe_price_list
    @subscriptions = Subscription.all
  end
  def success
    @plans = Stripe::Plan.list.data
  end

  def subscribe
    if current_user.stripe_id.nil?
      redirect_to success_path, :flash => {:error => 'Firstly you need to enter your card'}
      return
    end

    customer = Stripe::Customer.new current_user.stripe_id
    subscriptions = Stripe::Subscription.list(customer: customer.id)
    subscriptions.each do |subscription|
      subscription.delete
    end
    plan_id = params[:plan_id]
    subscription = Stripe::Subscription.create(
      {
        customer: customer,
        items: [{plan: plan_id}]
      }
    )
    subscription.save
    redirect_to success_path
  end

  def cancel_subscription
    Stripe::Subscription.cancel(stripe_subscription.id)

    @subscriptions = Subscription.all
    respond_to :html, :js
  end

  def pay_invoice
    invoice = Stripe::Invoice.create({
      customer: stripe_subscription.customer,
      subscription: subscription.stripe_id,
    })
    invoice.pay

    @subscriptions = Subscription.all
    respond_to :html, :js
  end

  private

  def stripe_price_list
    Stripe::Price.list(
      active: true,
      lookup_keys: Subscription::STRIPE_LOOKUP_KEYS,
      expand: ['data.product']
    ).data.sort_by(&:unit_amount)
  end

  def subscription
    @subscription ||= Subscription.find_by(id: params[:id])
  end

  def stripe_subscription
    @stripe_subscription ||= Stripe::Subscription.retrieve(subscription.stripe_id)
  end
end