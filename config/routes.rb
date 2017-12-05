Rails.application.routes.draw do
  root "orders#index"
  resources :orders
  match "*path", to: "orders#index", via: :all
end
