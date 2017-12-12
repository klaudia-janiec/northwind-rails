Rails.application.routes.draw do
  root "orders#index"
  resources :orders
  resources :products
  match "*path", to: "orders#index", via: :all
end
