Rails.application.routes.draw do
  root to: "home#index"
  get 'profile', to: 'users#show'
  resources :companies

  devise_for :users

  resources :users
  resources :teams
  resources :tracks
  resources :projects do
    resources :tracks
  end
end
