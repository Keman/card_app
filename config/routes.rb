Rails.application.routes.draw do
  root "static_pages#index"
  resources :cards
  resources :reviews
end
