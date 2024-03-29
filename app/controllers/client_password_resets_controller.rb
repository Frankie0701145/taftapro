# frozen_string_literal: true

class ClientPasswordResetsController < ApplicationController
  before_action :get_client,         only: %i[edit update]
  before_action :valid_client,       only: %i[edit update] # authenticates if the rest token matches with th received reset_token
  before_action :check_expiration, only: %i[edit update] # to check if the reset link has expired

  def new; end

  def create
    @client = Client.find_by(email: params[:client_password_reset][:email].downcase)
    if @client
      # creates a reset token,reset digest token and adds the reset_sent_at time
      @client.create_reset_digest
      # sending the mail to the recipient
      @client.send_password_reset_email
      # adding the flash info message
      flash[:info] = "Email sent with password reset instructions to this email #{@client.email}"
      # redirecting to the root url
      redirect_to root_url

    else
      # if the email address is not found create a danger flash message and render the reset_password
      flash.now[:danger] = "There is no client with that email address"
      render "new"
    end
  end

  def edit; end

  def update
    if params[:client][:password].empty?
      @client.errors.add(:password, "can't be empty")
      render "edit"
    elsif @client.update(client_params)
      client_login @client
      flash[:success] = "Password has been reset."
      redirect_to @client
    else
      render "edit"
    end
  end

  private

    # method to confirm the password and confirm password match
    def client_params
      params.require(:client).permit(:password, :password_confirmation)
    end

    # Before filters
    # method to find the client
    def get_client
      @client = Client.find_by(email: params[:email])
    end

    # confirm a valid client
    def valid_client
      redirect_to root_url unless @client&.authenticated?(:reset, params[:id])
    end

    def check_expiration
      if @client.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_client_password_reset_url
      end
    end
end
