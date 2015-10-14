Rails.application.routes.draw do
  root "static_pages#index"
  resources :cards
  resources :reviews
  resources :users
  resources :user_sessions
  resources :decks

  get "login" => "user_sessions#new", as: :login
  post "logout" => "user_sessions#destroy", as: :logout

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  get "make_main" => "decks#make_main"
  get "make_common" => "decks#make_common"

  get "delete_picture" => "cards#delete_picture"
end
