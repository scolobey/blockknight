Rails.application.routes.draw do
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
