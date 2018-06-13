Rails.application.routes.draw do
  get 'professionals/new'
  get 'professionals/index'
  get 'professionals/show'
  get 'professionals/edit'
  root 'static_pages#home'
  #the routes for the client login and logout
  get     "/client/login",  to:"client_sessions#new"
  post    "/client/login",   to:"client_sessions#create"
  delete  "/client/logout",  to:"client_sessions#destroy"

  get '/about', to: 'static_pages#about'
  get '/signup', to: 'clients#new'
  get '/search_service', to: 'static_pages#search_service'
  resources :clients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
