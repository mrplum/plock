Rails.application.routes.draw do
  root to: "home#index"
  get 'profile', to: 'users#show'
  resources :companies

  devise_for :users

  resources :users
  get 'me/data' => 'users#data', :defaults => { :format => 'json' }

  resources :teams
  resources :tracks
  resources :projects do
    resources :tracks
  end
end
