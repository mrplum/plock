Rails.application.routes.draw do
  resources :companies
  root to: "home#index"

  devise_for :users

  resources :users
  resources :teams
  resources :tracks
  resources :projects do
    resources :tracks
  end
end
