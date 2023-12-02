Rails.application.routes.draw do
  devise_for :users
  get 'items/index'
  root to: "items#index"
  resources :users, only: [:edit, :update]
  resources :items do
    resources :orders, only: [:index, :create]
  end
end