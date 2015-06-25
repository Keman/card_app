Rails.application.routes.draw do
  root "static_pages#index"
  get "/show" => "static_pages#show"
end
