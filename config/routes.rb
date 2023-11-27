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
  get 'subscription/success' => 'subscriptions#success'
  get 'subscription/failure' => 'subscriptions#failure'

  post 'subscription/checkout' => 'subscriptions#checkout'
  post 'billing/portal', to: 'billings#portal'
  post '/webhooks/stripe', to: 'webhooks#stripe'
end
