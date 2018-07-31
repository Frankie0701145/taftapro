Rails.application.routes.draw do

  
  root 'static_pages#home'
  #the routes for the client login and logout
  get     "/client/login",  to:"client_sessions#new"
  post    "/client/login",   to:"client_sessions#create"
  delete  "/client/logout",  to:"client_sessions#destroy"
  #the routes for the professional login and logout
  get     "/professional/login",  to: "professional_sessions#new"
  post    "/professional/login",  to: "professional_sessions#create"
  delete  "/professional/logout", to: "professional_sessions#destroy"

  get '/about', to: 'static_pages#about'
  get '/signup', to: 'clients#new'
  get "/professional/signup", to: 'professionals#new' #the route to the professional signup
  get '/search', to: 'static_pages#search'
  # get '/request_quotation', to: 'clients#get_quotation'
  get '/quotations', to: 'clients#quotations'
  post 'upload_quotation', to: 'professionals#upload_quotation'
  post '/submit_answers', to: 'answers#find_or_create_client'
  resources :clients
  resources :client_password_resets,  only: [:new, :create, :edit, :update]
  resources :professional_password_resets, only: [:new, :create, :edit, :update]
  resources :professionals
  resources :requests
  resources :answers, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
