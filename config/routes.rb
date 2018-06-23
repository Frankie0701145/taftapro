Rails.application.routes.draw do

  root 'static_pages#home'
  #the routes for the client login and logout
  get     "/client/login",  to:"client_sessions#new"
  post    "/client/login",   to:"client_sessions#create"
  delete  "/client/logout",  to:"client_sessions#destroy"
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'clients#new'
  get '/search_service', to: 'static_pages#search_service'
  get '/request_quotation', to: 'clients#get_quotation'
  post 'upload_quotation', to: 'professionals#upload_quotation'
  resources :clients
  resources :client_password_resets,  only: [:new, :create, :edit, :update]
  resources :professionals
  resources :requests
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
