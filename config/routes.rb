Rails.application.routes.draw do

  devise_for :users

  resources :teams
  resources :tasks
  resources :projects
end
