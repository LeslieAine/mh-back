Rails.application.routes.draw do
  devise_for :clients
  devise_for :creators, controllers: {
    sessions: 'creators/sessions', registrations: 'creators/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, 
  # path: '', path_names: {
  #   sign_in: 'login',
  #   sign_out: 'logout',
  #   registration: 'signup'
  # } 
   controllers: {
    sessions: 'users/sessions', registrations: 'users/registrations'
  }
  namespace :api do
    namespace :v1 do
      # resources :users, only: [:index, :show, :create, :update, :destroy] do
      #   member do
      #     post 'update_avatar'
      #   end
      # end

      # Transactions controller routes
      resources :transactions, only: [:create]

      # Contents controller routes
      resources :contents, only: [:index, :show]

      # Posts controller routes
      resources :posts, only: [:create, :index, :show, :destroy]

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
