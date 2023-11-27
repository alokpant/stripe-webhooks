class BillingsController < ApplicationController
  def portal
    session = Stripe::BillingPortal::Session.create({
      customer: current_user.stripe_customer_id,
      return_url: subscriptions_url
    })

    redirect_to session.url, allow_other_host: true
  end
end
