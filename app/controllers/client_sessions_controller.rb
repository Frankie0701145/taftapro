# frozen_string_literal: true

class ClientSessionsController < ApplicationController
  def new; end

  def create
    client = Client.find_by(email: params[:client_session][:email].downcase)

    if client&.authenticate(params[:client_session][:password])
      # loggin in the user
      client_login(client)
      redirect_back_or client
    else
      # render the login page again this time with a flash message
      flash.now[:danger] = "Invalid password or email"
      render "new"
    end
  end

  def destroy
    client_logout
    redirect_to root_url
  end
end
