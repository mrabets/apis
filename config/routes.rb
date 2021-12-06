Rails.application.routes.draw do
  get 'welcome/app'
  root 'welcome#app'
  
  post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :users, only: [:create]
      
      post "/login", to: "users#login"
      get "/auto_login", to: "users#auto_login"

      resources :photos do
        resources :likes, only: ['create']
        delete '/likes', to: 'likes#destroy'
      end
    end
  end
end
