Rails.application.routes.draw do
  devise_for :users

  root 'items#index'

  # Dashboard for current user
  get 'dashboard', to: 'users#dashboard', as: :dashboard

  resources :items, only: [:show, :new, :create, :destroy, :edit, :update] do
    resources :offers, only: [:new, :create]
    resources :ratings, only: [:new, :create, :update]
  end

  resources :offers, only: [:update, :destroy]
end
