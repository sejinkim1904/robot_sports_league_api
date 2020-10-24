Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :teams, only: [:create]
      post '/login', to: 'sessions#create'
    end
  end
end
