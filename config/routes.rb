Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v0 do
      post "customer", to: "customers#show"
      resources :teas, only: [:index, :show]
      post "subscribe", to: "subscriptions#subscribe"
      post "unsubscribe", to: "subscriptions#unsubscribe"
    end
  end
end
