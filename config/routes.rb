Rails.application.routes.draw do
  post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create'

  namespace :api do
    namespace :v1 do
      resources :photos
    end
  end
end
