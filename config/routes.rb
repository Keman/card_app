Rails.application.routes.draw do
  root "static_pages#index"
  patch "/check_translation" => "reviews#create"
  resources :cards
  resources :reviews
end
