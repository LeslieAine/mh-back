Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions', registrations: 'users/registrations'
  }
  namespace :api do
    namespace :v1 do
      # Transactions controller routes
      resources :transactions, only: [:create]

      # Contents controller routes
      resources :contents, only: [:index, :show]

      # Posts controller routes
      resources :posts, only: [:create, :index, :show]

      # Likes controller routes
      resources :likes, only: [:create, :destroy]

      # Bookmarks controller routes
      resources :bookmarks, only: [:create, :index, :destroy]

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

end
