Rails.application.routes.draw do
  resources :feed_items do
    collection do
      post 'approve_checked'
      post 'update_news'
    end
  end

  resources :users
  root "coins#index"
  resources :coins do
    collection do
      post 'follow'
    end
  end

  get '/about' => 'static_pages#about'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
  end
end
