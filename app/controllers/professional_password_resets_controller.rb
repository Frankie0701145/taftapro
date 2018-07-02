class ProfessionalPasswordResetsController < ApplicationController
  before_action :get_professional, only: [:edit, :update]
  before_action :valid_professional, only: [:edit, :update]
  def new
  end

  def create
      @professional = Professional.find_by(email: params[:professional_password_reset][:email].downcase)
      if @professional
        #create a reset token,reset digest token and adds the reset_sent_at time
        @professional.create_reset_digest
        #sending the mail to the recipient
        @professional.send_password_reset_email
        #adding the flash info message
        flash[:info] = "Email sent with password reset instruction to this email #{@professional.email}"
        #redirecting to the root url
        redirect_to root_url
      else
        #if the email address is not found create a warning flash message to tell the professional for the issue
        flash.now[:danger]= "There is no professional with that email address"
        render "new"
      end
  end

  def edit
  end
  private
    #retrieves the current professional
    def get_professional
      @professional= Professional.find_by(email: params[:email])
    end
    #confirms a valid professional
    def valid_professional
      unless(@professional &&
            @professional.authenticated?(:reset,params[:id]))
        redirect_to root_url
      end
    end
end
