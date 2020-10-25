Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :teams, only: [:create, :update]

      namespace :teams do
        resources :bots, only: [:index]
        post '/generate_bots', to: 'bots#create'
        post '/generate_roster', to: 'rosters#generate_roster'
        get '/roster', to: 'rosters#index'
        post '/roster', to: 'rosters#create'
      end

      post '/login', to: 'auth#login'
      get '/auto_login', to: 'auth#auto_login'
    end
  end
end
