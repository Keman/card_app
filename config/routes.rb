Rails.application.routes.draw do
  root "static_pages#index"
  post "translation_check" => "reviews#create"
  resources :cards
end
