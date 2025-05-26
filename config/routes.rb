Rails.application.routes.draw do
  devise_for :users
  root to: "offers#home"
  resources :offers, only: [:show, :new, :create, :edit, :update, :destroy]

end
