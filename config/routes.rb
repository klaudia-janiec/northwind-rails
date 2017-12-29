Rails.application.routes.draw do
  root "main#index"
  resources :main
  resources :orders
  resources :products
  resources :reports
  get "customers_without_orders", to: "reports#customers_without_orders"
  match "*path", to: "main#index", via: :all
end
