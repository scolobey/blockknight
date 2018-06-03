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
      post 'unfollow'
    end
  end

  resources :blog_posts

  get "/sitemap.xml" => "sitemap#index", :format => "xml", :as => :sitemap
  get '/about' => 'static_pages#about'
  get '/news' => 'news#index'
  get '/forum' => 'forum#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get :search, controller: :search

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
  end

end
