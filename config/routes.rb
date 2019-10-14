Rails.application.routes.draw do
  devise_for :users
  root 'games#index'

  resources :games, only: [:new, :create, :show, :update]
  resources :pieces, only: [:show, :update]
end
