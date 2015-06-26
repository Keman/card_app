Rails.application.routes.draw do
  root "static_pages#index"
  get "/show" => "cards#show"
end
