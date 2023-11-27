# app/controllers/webhooks_controller.rb

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      signing_secret = Rails.application.credentials.stripe[:development][:signing_secret]
      event = Stripe::Webhook.construct_event(
        payload, sig_header, signing_secret
      )
    rescue JSON::ParserError => e
      handle_bad_request(e)
      return
    rescue Stripe::SignatureVerificationError => e
      handle_bad_request(e)
      return
    end

    handle_event(event)

    render status: :ok, json: { received: true }
  end

  private

  def handle_event(event)
    case event.type
    when 'customer.subscription.created'
      # event.data.object is a Stripe::Subscription
      handle_subscription_creation(event.data.object)
    when 'invoice.payment_succeeded'
      handle_payment_succeeded(event['data']['object'])
    when 'customer.subscription.deleted'
      handle_subscription_deleted(event['data']['object'])
    end
  end

  def handle_subscription_creation(subscription)
    Subscription.where(stripe_id: subscription.id).first_or_create
  end

  def handle_payment_succeeded(invoice)
    subscription = Subscription.find_by(stripe_id: invoice['subscription'])
    subscription.update(status: 'paid') if subscription.present?
  end

  def handle_subscription_deleted(subscription)
    subscription_record = Subscription.find_by(stripe_id: subscription['id'])
    subscription_record.update(status: 'canceled') if subscription_record.present? && subscription_record.paid?
  end

  def handle_bad_request(e)
    render status: :bad_request, json: { error: e.message }
  end
end
