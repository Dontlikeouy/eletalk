Rails.application.routes.draw do
  resources :tests
  # -----ROOT-----
  root to: 'feed#index'
  get '/feed/:post_id', to: 'feed#feed', as: 'feed'

  # ----PROFILE-----
  get '/profile', to: 'profile#profile', as: 'profile'

  # ----POSTS-----
  get '/post/new', to: 'posts#new', as: 'post_new'
  post '/post/create', to: 'posts#create', as: 'post_create'
  get '/post/:post_id/edit', to: 'posts#edit', as: 'post_edit'
  post '/post/:post_id/update', to: 'posts#update', as: 'post_update'
  delete '/post/:post_id/destroy', to: 'posts#destroy', as: 'post_destroy'

  #----COMMENTS-----
  post '/comment/:post_id/create', to: 'comment#create', as: 'comment_create'
  post '/comment/:post_id/update', to: 'comment#update', as: 'comment_update'

  #----FAVORITE-----
  post '/favorite/:post_id', to: 'favorite#favorite', as: 'favorite'
  post '/unfavorite/:post_id', to: 'favorite#unfavorite', as: 'unfavorite'

  #----SUBCRIBE-----
  post '/subscribe/:owner_id', to: 'subscribe#subscribe', as: 'subscribe'
  post '/unsubscribe/:owner_id', to: 'subscribe#unsubscribe', as: 'unsubscribe'

  get '/profile/:user_id', to: 'profile#another_profile', as: 'another_profile'

  # ----USERS-----
  get '/login', to: 'users#index', as: 'login'
  post '/login/create', to: 'users#login', as: 'login_create'
  delete '/login/logout', to: 'users#logout', as: 'logout'
end
