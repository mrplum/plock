Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  root to: "home#index"
  get 'profile', to: 'users#show'
  resources :companies do
      get 'subscribe_user'
      get 'send_email'
      get 'accept_invitation_to_company', on: :collection
  end


  devise_for :users
  resources :users
  get 'me/data' => 'users#data', :defaults => { :format => 'json' }
  resources :teams do
    get 'accept_invitation', on: :member
  end
  resources :tracks
  resources :projects do
    resources :tracks
  end

  scope :admin do
    get '/', to: 'statics#dashboard'
    get '/models_count', to: 'statics#models_count'
    namespace :statics do
      resources :companies do
        get :companies_table, on: :collection
      end
      resources :intervals do
        get :intervals_table, on: :collection
      end
      resources :tracks do
        get :tracks_table, on: :collection
      end
      resources :users do
        get :users_table, on: :collection
        get :user_select, on: :collection
      end
      resources :projects do
        get :projects_table, on: :collection
      end
      resources :teams do 
        get :teams_table, on: :collection
      end
    end
  end
end
