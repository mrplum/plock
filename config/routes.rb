Rails.application.routes.draw do
  resources :companies
  root to: "home#index"

  devise_for :users

  resources :teams
  resources :tasks
  resources :projects
end
