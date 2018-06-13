class ClientPasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update] #to check if the reset link has expired

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

  def update
      if params[:client][:password].empty?
        @client.errors.add(:password, "can't be empty")
      elsif @client.update_attributes(user_params)
        client_login @client
        flash|:success| = "Password has been reset."
        redirect_to @client
      else
        render "edit"
      end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # Before filters

    def get_user
      @client = Client.find_by(email: params[:email])
    end

    #confirm a valid client
    def valid_user
      unless(@client && @client.authenticated?( :reset, params[:id]))
        redirect_to root_url
      end
    end

    def check_expiration
      if @client.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_client_password_reset
      end
    end

end
