Rails.application.routes.draw do
  resources :companies
  root to: "home#index"

  devise_for :users

  resources :users
  resources :teams
  resources :tasks
  resources :projects do
    resources :tasks
  end
end
