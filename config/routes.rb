Rails.application.routes.draw do

  get 'static_pages/home'
  get 'static_pages/about'

  #the routes for the client login and logout
  get     "/client/login",  to:"client_sessions#new"
  post    "client/login",   to:"client_sessions#create"
  delete  "client/logout",  to:"client_sessions#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
