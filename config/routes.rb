Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :teams, only: [:create, :update]

      namespace :teams do
        resources :bots, only: [:create]
        post '/generate_roster', to: 'rosters#generate_roster'
      end

      post '/login', to: 'auth#login'
      get '/auto_login', to: 'auth#auto_login'
    end
  end
end
