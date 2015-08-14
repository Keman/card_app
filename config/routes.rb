Rails.application.routes.draw do
  root "static_pages#index"
  post "translation_check" => "static_pages#translation_check"
  resources :cards
end
