class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @prices = stripe_price_list
    @subscriptions = Subscription.where(user_id: current_user.id)
  end

  def checkout
    session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      mode: 'subscription',
      line_items: [{
        quantity: 1,
        price: params['price_id']
      }],
      success_url: subscription_success_url,
      cancel_url: subscription_failure_url
    })

    redirect_to session.url, allow_other_host: true
  end

  def success
    flash[:notice] = 'Your subscription was created successfully'
    redirect_to subscriptions_path
  end

  def failure
    flash[:alert] = 'There was some problem with your subscription'
    redirect_to subscriptions_path
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