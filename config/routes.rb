Rails.application.routes.draw do
  root "static_pages#index"
  get "/repeat" => "reviews#new"
  post "translation_check" => "reviews#create"
  resources :cards
end
