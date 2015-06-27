Rails.application.routes.draw do
  root "static_pages#index"
  get "/cards" => "cards#index"
end
