Rails.application.routes.draw do

  root to: "homepages#index"

  get "/app", to: "communities#index"

  delete '/logout', to: 'user_sessions#destroy', as: 'logout'

  get '/join/:id', to: 'join_communities#join', as: 'join_community'

  get '/join_request/:id', to: 'join_communities#join_request', as: 'request_to_join_community'

  get '/leave_community/:id', to: 'join_communities#leave_community', as: 'leave_community'

  get '/delete_community/:id', to: 'join_communities#delete_community', as: 'delete_community'

  get '/accept_request/:id', to: 'join_communities#accept_request', as: 'accept_request_to_join_community'

  resource :user_sessions, only: [:new, :create, :destroy]

  resources :users

  resources :communities

  resources :join_communities, only: [:index, :join]

  get '/like_post/:id', to:"messages#like_post", as: "like_post"

  resources :chat_rooms do
    resources :messages
  end

end
