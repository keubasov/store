Rails.application.routes.draw do
  resources :products
  root 'products#index'
  resources :looks
  resources :catalog, only: [:index]
end
