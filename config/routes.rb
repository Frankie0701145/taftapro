Rails.application.routes.draw do
  get 'client_password_resets/new'
  get 'client_password_resets/edit'
  root 'static_pages#home'
  #the routes for the client login and logout
  get     "/client/login",  to:"client_sessions#new"
  post    "/client/login",   to:"client_sessions#create"
  delete  "/client/logout",  to:"client_sessions#destroy"

  get '/about', to: 'static_pages#about'
  get '/signup', to: 'clients#new'
  resources :clients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
