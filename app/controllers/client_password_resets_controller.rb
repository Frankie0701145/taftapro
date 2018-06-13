class ClientPasswordResetsController < ApplicationController

  def new
  end


  def create

    @client = Client.find_by(email: params[:client_password_reset][:email].downcase)
    if @client
      #creates a reset digest token and adds the reset_sent_at time
      @client.create_reset_digest
      #sending the mail to the recipient
      @client.send_password_reset_email
      #adding the flash info message
      flash[:info] = "Email sent with password reset instructions"
      #redirecting to the root url
      redirect_to root_url

    else
      #if the email address is not found create a danger flash message and render the reset_password
      flash.now[:danger]="There is no client with that email address"
      render "new"
    end
  end

  def edit
  end
end
