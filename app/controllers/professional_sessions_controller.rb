class ProfessionalSessionsController < ApplicationController

  def new
  end

  def create
    professional= Professional.find_by(email: params[:professional_session][:email].downcase)

    if professional && professional.authenticate(params[:professional_session][:password])
      #login the profesional
      professional_login(professional)
      flash.now[:success]="Login in As professional"
      render 'new'
    else
      #the pro does not login
      flash.now[:danger] = "Invalid password/email"
      render "new"
    end

  end
end
