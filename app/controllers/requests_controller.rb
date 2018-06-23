class RequestsController < ApplicationController

	def create
		request = Request.new(request_params)
		if request.save
			location = request.location
			service = request.service
			password = Client.create_password

			@client = Client.find_by(email: request.user_email) || 
					 Client.create!(
					 	first_name: request_params[:first_name],
					 	last_name: request_params[:last_name],
					 	email: request_params[:user_email],
					 	password: password,
					 	password_confirmation: password)

			professionals = Professional.near(location) && Professional.where(service: service)  		
			# Send each of these professionals an email informing them of the request
			professionals.each do |pro|
				@client.request_quotation(professional: pro, request: request)
			end
			client_login @client
			redirect_to client_path(@client)
		end
	end

	private
	def request_params
		params.require(:request).permit(:service, :location, :description, :user_email, :first_name, :last_name)
	end
end
