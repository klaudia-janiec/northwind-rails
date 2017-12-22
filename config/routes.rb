Rails.application.routes.draw do
  root "main#index"
  resources :main
  resources :orders
  resources :products
  resources :reports
  match "*path", to: "main#index", via: :all
end
