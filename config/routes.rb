Rails.application.routes.draw do
  get 'welcome/app'
  root 'welcome#app'
  
  post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create'

  namespace :api do
    namespace :v1 do
      resources :photos
    end
  end
end
