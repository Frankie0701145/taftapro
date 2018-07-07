class RequestsController < ApplicationController

	def create
		request = Request.new(request_params)
		if request.save
				@professional=Professional.find_by(email: params[:professional_email].downcase)
				if @professional
					@client=current_client
					@client.request_quotation(professional:@professional, request:request)
					flash[:success]="The quotation request has been sent."
					redirect_to client_path(@client)
				else
					flash[:danger]="The quotation request was not sent"
					redirect_to professional_path(@professional)
				end
		else
				flash[:danger]="The quotation request was not sent"
				redirect_to professional_path(@professional)
		end
=begin
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
			flash[:success] = "We will notify you when the professionals send you a quote."
			redirect_to client_path(@client)
		end
=end
	end

	private
	def request_params
		params.require(:request).permit( :description, :first_name,:last_name, :location, :service, :user_email)
	end
end
