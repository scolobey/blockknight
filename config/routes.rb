Rails.application.routes.draw do
  resources :feed_items do
    collection do
      post 'approve_checked'
    end
  end

  resources :users
  root "coins#index"
  resources :coins
  get '/about' => 'static_pages#about'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
end
