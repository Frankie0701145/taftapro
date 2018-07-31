class AnswersController < ApplicationController
	def create
		answer = Answer.new(answer_params)

		answer.save
			
	end  

	def find_or_create_client
		answer = Answer.new(answer_params)

		location = params[:location]
		service = params[:service]		
		
		if answer.save
			# This answer should contain the client's email
			@client = Client.find_by(email: answer.answer)
			if @client
				flash[:info] = "Looks like you are an existing user. Please log in to continue."
				redirect_to client_login_path
			else
				password = SecureRandom.hex(6)
				@client = Client.create(email: answer.answer, password: password, password_confirmation: password)
				client_login(@client)
				flash[:success] = "Welcome! We have emailed you a temporary password. Please change it."
				# TO-DO: ACTUALLY SEND THE EMAIL WITH THE PASSWORD
				redirect_to professionals_path(location: location, service: service)
			end
			

			answers = Answer.where(client_token: answer.client_token)
			answers.each do |answer|
				answer.update_attribute(:client_id, @client.id)
			end
		end
	end

	private

		def answer_params
			params.require(:answer).permit(:answer, :question_id, :client_id, :client_token)
		end
end
