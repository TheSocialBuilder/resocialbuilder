Resocialbuilder::Application.routes.draw do
  
  match 'listings/mls', to: 'listings#mls', as: 'mls'
  
  resources :accounts
  resources :realtors
  resources :blogs
  resources :pages
  resources :listings
  
  
  match 'listings/mls', to: 'listings#mls', as: 'mls'

  root :to => 'welcome#index'
end
