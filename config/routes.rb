require 'sidekiq/web'

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  authenticate :user, lambda { |u| u.company&.owner_id == u.id && u.admin } do
    mount Sidekiq::Web => '/sidekiq'
    scope :admin do
      get '/', to: 'stadistics#dashboard'
      get '/models_count', to: 'stadistics#models_count'
      namespace :stadistics do
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

  scope "(:locale)", locale: /en|es/ do

    root to: "home#index"

    get 'profile', to: 'users#show'
    get 'user/stadistics', to: 'users#stadistics'
    resources :companies do
      get 'subscribe_user'
      get 'send_email'
      get 'accept_invitation_to_company', on: :collection
      get :report_employees
      post :send_report
    end


    devise_for :users
    resources :users

    resources :teams do
      get 'accept_invitation', on: :member
    end
    resources :tracks do
      resources :intervals
    end
    resources :areas
    resources :projects do
      resources :tracks
    end

    get 'users/:id/calendar', to: "users#calendar", as: :calendar
    patch 'users/:id/remove_avatar', to: "users#remove_avatar", as: :remove_avatar
    patch 'companies/:id/remove_logo', to: "companies#remove_logo", as: :remove_logo

    get 'me/dataUser/events' => 'users#events', :defaults => { :format => 'json' }

    # Routes for stats
    get 'me/dataUser/hoursInTracks' => 'users#data_user_in_tracks', :defaults => { :format => 'json' }
    get 'me/dataUser/hoursInTeams' => 'users#data_user_in_teams', :defaults => { :format => 'json' }
    get 'me/dataUser/hoursInProjects' => 'users#data_user_in_projects', :defaults => { :format => 'json' }
    get 'me/dataUser/hoursIntervalTime' => 'users#hours_interval_time', :defaults => { :format => 'json' }
    get 'me/dataTeam/hoursMembers' => 'teams#hours_members_team', :defaults => { :format => 'json' }
    get 'me/dataTeam/hoursToProjects' => 'teams#hours_to_projects', :defaults => { :format => 'json' }
    get 'me/dataTracks' => 'tracks#data_tracks', :defaults => { :format => 'json' }
  end
end
