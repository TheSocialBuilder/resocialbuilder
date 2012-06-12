Resocialbuilder::Application.routes.draw do
  
  match 'listings/nnrmls', to: 'listings#nnrmls', as: 'nnrmls'
  match 'listings/stgeorge', to: 'listings#stgeorge', as: 'stgeorge'
  match 'listings/mls', to: 'listings#mls', as: 'mls'
  
  
  resources :accounts
  resources :realtors
  resources :blogs
  resources :pages
  resources :listings
  
  


  root :to => 'welcome#index'
end
