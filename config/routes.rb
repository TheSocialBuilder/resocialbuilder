Resocialbuilder::Application.routes.draw do
  
  resources :accounts
  resources :realtors
  resources :blogs
  resources :pages
  
  


  root :to => 'welcome#index'
end
