# frozen_string_literal: true

class ProfessionalSessionsController < ApplicationController
  def new; end

  def create
    professional = Professional.find_by(email: params[:professional_session][:email].downcase)

    if professional&.authenticate(params[:professional_session][:password])
      # login the profesional
      professional_login(professional)
      flash[:success] = "You have successfully logged in."
      redirect_back_or professional
    else
      # the pro does not login
      flash.now[:danger] = "Invalid password/email"
      render "new"
    end
  end

  def destroy
    professional_logout
    redirect_to root_url
  end
end
