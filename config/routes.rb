Rails.application.routes.draw do

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  # devise_for :clients, controllers: {
  #   sessions: 'clients/sessions', registrations: 'clients/registrations'
  # }
  # devise_for :creators, controllers: {
  #   sessions: 'creators/sessions', registrations: 'creators/registrations'
  # }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # devise_for :users, 
  # path: '', path_names: {
  #   sign_in: 'login',
  #   sign_out: 'logout',
  #   registration: 'signup'
  # } 
  #  controllers: {
  #   sessions: 'users/sessions', registrations: 'users/registrations'
  # }
  namespace :api do
    namespace :v1 do
      # resources :users, only: [:index, :show, :create, :update, :destroy] do
      #   member do
      #     post 'update_avatar'
      #   end
      # end
      # resources :users, only: [:update] do
      #   post "/message_history", to: "messages#message_history"
      #   post "/create_message", to: "messages#create_message"
      #   get "/message_histories", to: "messages#message_histories"
        # get "/matches/:recipient_id", to: "matches#get_match"
      # end
      # resources :rooms
      # resources :users
      resources :conversations, only: [:create, :index, :show]
      resources :messages, only: [:index, :create]
      resources :users, only: [:index, :show]
      # post '/login', to: 'users#login'
      # resources :chatrooms, only: [:index, :create, :show]

  #   resources :messages, only: [:index, :create]
  #   resources :users, only: [:index, :create] do
  #     member do
  #       get 'chatrooms'
  #     end
  #   end
  #   resources :chatrooms, only: [:index, :create, :show]
  # end

      # resources :chats, only: [:index, :create]
      # resources :messages, only: [:create]
      # resources :chatrooms do
      #   resources :messages
      # end 


      # post "/users/:id", to: "users#index"
      # resources :publishers
      resources :roles

      # Transactions controller routes
      resources :transactions, only: [:create]

      # Contents controller routes
      resources :contents, only: [:create, :index, :show, :destroy]

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

  mount ActionCable.server => "/cable"

end
