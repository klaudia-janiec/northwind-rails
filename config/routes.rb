Rails.application.routes.draw do
  root "orders#index"
  resources :orders
  resources :products
  resources :reports
  match "*path", to: "orders#index", via: :all
end
