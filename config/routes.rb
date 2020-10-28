Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :teams do
        resources :bots, only: [:index]
        post '/generate_bots', to: 'bots#create'
        post '/generate_roster', to: 'rosters#generate_roster'
        get '/current_roster', to: 'rosters#current_roster'
        get '/roster', to: 'rosters#index'
        patch '/roster/:id', to: 'rosters#update'
        delete '/roster', to: 'rosters#destroy'
      end

      resources :teams, only: [:create, :update]

      post '/login', to: 'auth#login'
      get '/auto_login', to: 'auth#auto_login'
    end
  end
end
