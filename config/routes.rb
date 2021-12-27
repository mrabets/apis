Rails.application.routes.draw do
  post '/rails/active_storage/direct_uploads', to: 'direct_uploads#create'

  devise_for :users, defaults: { format: :json },
                     controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations'
                     }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :photos do
        resources :likes, only: ['create', 'destroy']
        delete '/likes', to: 'likes#destroy'
        get 'like_status', to: 'likes#status'
        get 'like_count', to: 'likes#count'
      end

      get '/member-data', to: 'members#show'
    end
  end
end
