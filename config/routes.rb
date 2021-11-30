Rails.application.routes.draw do
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  
  post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create'

  namespace :api do
    namespace :v1 do
      resources :photos
    end
  end
end
