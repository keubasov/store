Rails.application.routes.draw do
  resources :products
  root 'catalog#index'
  resources :looks
  resources :catalog, only: [:index, :show]
end
