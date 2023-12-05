Rails.application.routes.draw do

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

  namespace :api do
    namespace :v1 do

      resources :notifications
      resources :chats
      # resource :abouts, only: [:show, :edit, :update]

      get "/:user_id/mark-all-as-seen", to: "notifications#mark_all_as_seen"

      resources :users, only: [:index, :show] do
        member do
          get 'made_orders', to: 'orders#made_orders'
          get 'received_orders', to: 'orders#received_orders'
          get 'pending_orders', to: 'orders#pending_orders'
          get 'creator_fulfilled_orders', to: 'orders#creator_fulfilled_orders'
          get 'client_fulfilled_orders', to: 'orders#client_fulfilled_orders'
          get 'current_balance'
        end

      resource :abouts, only: [:show, :edit, :update]

        # member do
          post 'follow', to: 'users#follow', as: 'follow'
          delete 'unfollow', to: 'users#unfollow', as: 'unfollow'
          get 'followers', to: 'users#followers', as: 'followers'
          get 'followees', to: 'users#followees', as: 'followees'
        # end
      end

      resources :roles
      resources :orders, only: [:create] do
        member do
          post 'accept'
          post 'reject'
        end
      end
    
      resources :purchases, only: [:create]

      # Transactions controller routes
      # resources :transactions, only: [:create]

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
          patch 'fulfill'
        end
      end

      # Favorites controller routes
      resources :favorites, only: [:create, :index, :destroy]
    end
  end

  mount ActionCable.server => "/cable"

end
