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
		# pro_email = params[:professional_email]
		# This answer should contain the client's email


		if answer.save
			@professional = Professional.find_by(email: answer.professional_email)
			
			answers = Answer.where(client_token: answer.client_token)
			if !client_logged_in?
				@client = Client.find_by(email: answer.answer)
				if @client
					flash[:info] = "Looks like you are an existing user. Your quotation request has been sent successfully to #{@professional.full_name}. Please login to continue."
					request = Request.create(location:location, service:service, client_id: @client.id, professional_id: @professional.id)
					answers.each do |answer|
						answer.update_attributes(client_id: @client.id, request_id: request.id)
					end
					@client.request_quotation(professional:@professional, request:request, answers:answers)
					redirect_to professionals_path(location: location, service: service)
				else
					password = SecureRandom.hex(6)
					@client = Client.create(email: answer.answer, password: password, password_confirmation: password)
					client_login(@client)
					request = Request.create(location:location, service:service, client_id: @client.id, professional_id: @professional.id)
					answers.each do |answer|
						answer.update_attributes(client_id: @client.id, request_id: request.id)
					end
					flash[:success] = "Welcome! We have emailed you a temporary password. Please change it. Your quotation request has been sent successfully to #{@professional.full_name}.Please complete your profile."
					@client.request_quotation(professional:@professional, request:request, answers:answers)
					@client.password_send(password)
					redirect_to professionals_path(location: location, service: service)
				end
			else
				@client = current_client
				request = Request.create(location:location, service:service, client_id: @client.id, professional_id: @professional.id)
				answers.each do |answer|
					answer.update_attributes(client_id: @client.id, request_id: request.id)
				end
				flash[:success] = "Your quotation request has been sent successfully to #{@professional.full_name}."
				@client.request_quotation(professional:@professional, request:request, answers:answers)
				redirect_to professionals_path(location: location, service: service)
			end

		end
	end

	private

		def answer_params
			params.require(:answer).permit(:answer, :question_id, :client_id, :client_token, :professional_email)
		end

end
