Rails.application.routes.draw do

  root 'static_pages#home'
  #the routes for the client login and logout
  get     "/client/login",  to:"client_sessions#new"
  post    "/client/login",   to:"client_sessions#create"
  delete  "/client/logout",  to:"client_sessions#destroy"
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'clients#new'
  get "/professional/signup", to: 'professionals#new' #the route to the professional signup
  get '/search_service', to: 'static_pages#search_service'
  get '/request_quotation', to: 'clients#get_quotation'
  resources :clients
  resources :client_password_resets,  only: [:new, :create, :edit, :update]
  resources :professionals
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
