Rails.application.routes.draw do
  root to: "homepages#index"

  get 'searches/index'

  resources :tags

  get "/app", to: "communities#index"

  delete '/logout', to: 'user_sessions#destroy', as: 'logout'

  get '/join/:id', to: 'join_communities#join', as: 'join_community'

  get '/join_request/:id', to: 'join_communities#join_request', as: 'request_to_join_community'

  get '/leave_community/:id', to: 'join_communities#leave_community', as: 'leave_community'

  get '/delete_community/:id', to: 'join_communities#delete_community', as: 'delete_community'

  get '/accept_request/:id', to: 'join_communities#accept_request', as: 'accept_request_to_join_community'

  get '/reject_request/:id', to: 'join_communities#reject_request', as: 'reject_request_to_join_community'

  delete '/delete_post/:id', to: 'video_posts#delete_post', as: 'delete_post'

  resource :user_sessions, only: [:new, :create, :destroy]

  resources :users do
    resource :interest
  end

  resources :communities

  get '/join/communities/:community_id/user/:id', to:"join_communities#show", as:"share_community"

  get '/explore', to:"explore#index", as:"explore"

  resources :join_communities, only: [:index, :join]

  get '/like_post/:id', to:"messages#like_post", as: "like_post"

  resources :chat_rooms do
    resources :messages do
      resource :like, module: :messages
    end
  end

  resources :e_learning_chat_rooms do
    resources :video_posts do
      resources :comments
      resource :like, module: :video_posts
    end
  end

  # resources :interests
  get 'users/:id/user_interests', to: 'users#user_interests', as: 'user_interests'

  resources :sports_chat_rooms

  post '/create_new_notification', to:"notifications#new", as:'create_new_notification'

end
