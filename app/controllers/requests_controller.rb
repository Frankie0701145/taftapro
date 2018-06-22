class RequestsController < ApplicationController

	def create
		request = Request.new(request_params)
		if request.save
			location = request.location
			service = request.service

			client = Client.find_by(email: request.user_email) || 
					 Client.create(
					 	first_name: request.first_name,
					 	last_name: request.last_name,
					 	email: request.user_email)

			professionals = Professional.near(location) && Professional.where(service: service)  		
			# Send each of these professionals an email informing them of the request
			professionals.each do |pro|
				client.request_quotation(professional: pro, request: request)
			end
		end
	end

	private
	def request_params
		params.require(:request).permit(:service, :location, :description, :user_email, :first_name, :last_name)
	end
end
