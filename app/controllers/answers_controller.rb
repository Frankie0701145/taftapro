class AnswersController < ApplicationController
	def create
		answer = Answer.new(answer_params)

		answer.save

		respond_to do |format|
			format.html {}
			format.js
		end

	end

	def find_or_create_client
		answer = Answer.new(answer_params)

		location = params[:location]
		service = params[:service]
		pro_email = params[:professional_email]
		# This answer should contain the client's email

		@professional = Professional.find_by(email: pro_email)
		answers = Answer.where(client_token: answer.client_token)

		if answer.save

			if !client_logged_in?
				@client = Client.find_by(email: answer.answer)
				if @client
					flash[:info] = "Looks like you are an existing user. Your quotation request has been sent successfully to #{@professional.first_name} #{@professional.last_name}. Please login to continue."
					request = Request.create(location:location, service:service, client_id: @client.id, professional_id: @professional.id)
					answers.each do |answer|
						answer.update_attributes(client_id: @client.id, request_id: request.id)
					end
					redirect_to professionals_path(location: location, service: service)
				else
					password = SecureRandom.hex(6)
					@client = Client.create(email: answer.answer, password: password, password_confirmation: password)
					client_login(@client)
					request = Request.create(location:location, service:service, client_id: @client.id, professional_id: @professional.id)
					answers.each do |answer|
						answer.update_attributes(client_id: @client.id, request_id: request.id)
					end
					flash[:success] = "Welcome! We have emailed you a temporary password. Please change it. Your quotation request has been sent successfully to #{@professional.first_name} #{@professional.last_name}."
					# TO-DO: ACTUALLY SEND THE EMAIL WITH THE PASSWORD
					redirect_to professionals_path(location: location, service: service)
				end
			else
				@client = current_client
				request = Request.create(location:location, service:service, client_id: @client.id, professional_id: @professional.id)
				answers.each do |answer|
					answer.update_attributes(client_id: @client.id, request_id: request.id)
				end
				flash[:success] = "Your quotation request has been sent successfully to #{@professional.first_name} #{@professional.last_name}."
				redirect_to professionals_path(location: location, service: service)
			end

		end
	end

	private

		def answer_params
			params.require(:answer).permit(:answer, :question_id, :client_id, :client_token)
		end

end
