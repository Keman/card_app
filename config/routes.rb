Rails.application.routes.draw do
  root "static_pages#index"
  resources :cards
  resources :reviews
  resources :users
  resources :user_sessions

  get "login" => "user_sessions#new", as: :login
  post "logout" => "user_sessions#destroy", as: :logout

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
