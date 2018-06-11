Rails.application.routes.draw do

  get 'static_pages/home'
  get 'static_pages/about'

  #the routes for the client login and logout
  get     "/login",  to:"client_sessions#new"
  post    "/login",  to:"client_sessions#create"
  delete  "logout",  to:"client_sessions#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
