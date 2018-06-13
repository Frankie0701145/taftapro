
class ClientSessionsController < ApplicationController

  def new
  end

  def create
    client = Client.find_by(email: params[:client_session][:email].downcase)

    if client && client.authenticate(params[:client_session][:password])
      #loggin in the user
      client_login client
      render html:"<h1>Welcome</h1>"
    else
      #render the login page again this time with a flash message
      flash.now[:danger]="Invalid password or email"
      render "new"
    end
  end

  def destroy
    client_logout
    render html:"<h1></logged_out</h1>"
  end

end
