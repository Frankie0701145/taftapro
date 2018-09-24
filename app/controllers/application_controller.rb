class ApplicationController < ActionController::Base

  #including the client_sessions_helper to be available to all the controllers
  include ClientSessionsHelper

  private
  	# Confirms a logged-in client.
	def logged_in_client
		if !client_logged_in? && !professional_logged_in?
			store_location
			flash[:danger] = "Please log in to continue."
			redirect_to client_login_url
		end
	end
  def logged_in_professional

    unless professional_logged_in?
      if client_logged_in?
        flash[:info] = "You are not allowed to access this page."
        redirect_to current_client 
        return
      end

      store_location
      flash[:danger]= "Please log in to continue"
      redirect_to professional_login_url
    end
  end
end
