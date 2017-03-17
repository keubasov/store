Rails.application.routes.draw do
  resources :products
  root 'catalog#index', b_material: 'unbleached_calico', childs: false
  resources :looks
  resources :catalog, only: [:index, :show]
end
