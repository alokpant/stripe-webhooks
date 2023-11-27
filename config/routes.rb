Rails.application.routes.draw do
  devise_for :users, controllers: {
    session: 'users/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  resources :subscriptions  do
    member do
      post :pay_invoice
      post :cancel_subscription
    end
  end
  root "subscriptions#index"
  post 'subscription/checkout' => 'subscriptions#checkout'
  get 'subscription/success' => 'subscriptions#success'
  get 'subscription/failure' => 'subscriptions#failure'

  # post '/pay_invoice' => 'subscriptions#pay_invoice', as: :pay_invoice
  # post '/cancel_subscription' => 'subscriptions#cancel_subscription', as: :cancel_subscription

  # get '/card/new' => 'subscriptions#new_card', as: :add_payment_method
  # post "/card" => "subscriptions#create_card", as: :create_payment_method
  # get '/success' => 'subscriptions#success', as: :success
  # post '/subscription' => 'subscriptions#subscribe', as: :subscribe

  post '/webhooks/stripe', to: 'webhooks#stripe'
end
