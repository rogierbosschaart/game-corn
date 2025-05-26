Rails.application.routes.draw do
  devise_for :users

  root 'items#index'

  # Dashboard for current user
  get 'dashboard', to: 'users#dashboard', as: :dashboard

  resources :items, only: [:index, :show, :new, :create] do
    resources :offers, only: [:new, :create]
  end

  resources :offers, only: [:show, :edit, :update, :destroy]
end
