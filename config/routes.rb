Resocialbuilder::Application.routes.draw do
  
  

  constraints(:subdomain => 'soulmate') do
    mount Soulmate::Server, :at => '/'
  end
  
  constraints(:subdomain => 'dev') do
    mount Resque::Server, :at => '/resque'
    scope :module => "dev" do
      get '/sprites/:id' => 'dev#sprites'
      get '/sprites' => 'dev#sprites'
      get '/schema' => 'dev#schema'
      root to: "dev#index"
    end
  end
  
  match '/dashboard', to: 'dashboard::dashboard#index', as: 'dashboard'
  match '/login', to: 'accounts#login'
  match '/logout', to: 'accounts#logout'

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: 'home::register#new', as: 'register'
  
  
  match 'listings/nnrmls', to: 'listings#nnrmls', as: 'nnrmls'
  match 'listings/stgeorge', to: 'listings#stgeorge', as: 'stgeorge'
  match 'listings/mls', to: 'listings#mls', as: 'mls'
  
  mount Ckeditor::Engine => "/ckeditor"
  
  namespace :dashboard do
    
    
    
    match '/', to: 'dashboard#index', as: 'dashboard'
    match '/mls', to: 'dashboard#mls', as: 'mls'
    match '/menu', to: 'dashboard#menu', as: 'menu'
    match '/support', to: 'dashboard#support', as: 'support'
    match '/settings', to: 'dashboard#settings', as: 'settings'
    post '/savesort' => 'pages#savesort'
    
    
    
    resources :blogs do
      resources :comments
    end
    
    get 'blogs/:id/manage_comments', to: 'blogs#manage_comments', as: 'manage_comments'
    
    resources :accounts
    resources :comments
    resources :pages
    resources :links
    resources :widgets
    resources :realtors
    resources :listings
    resources :transactions
    resources :cards
    resources :facebook_posts

    
  end
  
  
  
  constraints(Subdomain) do
    
    namespace :api do
      namespace :v1, :defaults => { :format => 'json' } do
        resources :blogs
        resources :pages
        resources :accounts
        resources :listings
      end
    end
  
    get '/listings', to: 'profile::profile#listings', as: 'listings', :via => :get
    match '/listing/:mls_list_id', to: 'profile::profile#listing', as: 'listing', :via => :get
    
    
    match '/blogs/:id', to: 'profile::profile#blogs', as: 'blogs', :via => :get
    get '/blogs', to: 'profile::profile#blogs', as: 'blogs', :via => :get
    
    match '/:id', to: 'profile::profile#page', as: 'page', :via => :get
    
    root to: 'profile::profile#index'
  end
  

  resources :accounts
  resources :realtors
  resources :listings
  
  root :to => 'home::home#index'
  
end
