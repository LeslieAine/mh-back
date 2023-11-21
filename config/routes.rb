Rails.application.routes.draw do

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

  namespace :api do
    namespace :v1 do

      resources :notifications
      resources :chats

      get "/:user_id/mark-all-as-seen", to: "notifications#mark_all_as_seen"

      resources :users, only: [:index, :show] do
        resources :rooms
        resources :notifications
      end

      resources :roles

      # Transactions controller routes
      resources :transactions, only: [:create]

      # Contents controller routes
      resources :contents, only: [:create, :index, :show, :destroy]

      # Posts controller routes
      resources :posts, only: [:create, :index, :show, :destroy] do
        resources :likes
        resources :bookmarks
      end

      # Likes controller routes
      # resources :likes, only: [:create, :destroy]

      # Bookmarks controller routes
      # resources :bookmarks, only: [:create, :index, :destroy]

      # Messages controller routes
      resources :messages, only: [:create, :index]

      # Orders controller routes
      resources :orders, only: [:create] do
        member do
          post 'accept'
          post 'reject'
        end
      end

      # Favorites controller routes
      resources :favorites, only: [:create, :index, :destroy]
    end
  end

  mount ActionCable.server => "/cable"

end
