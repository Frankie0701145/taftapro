class ApplicationController < ActionController::Base

  #including the client_sessions_helper to be available to all the controllers
  include ClientSessionsHelper

  private
  	# Confirms a logged-in client.
	def logged_in_client
		unless client_logged_in?
			store_location
			flash[:danger] = "Please log in to continue."
			redirect_to client_login_url
		end
	end
end
