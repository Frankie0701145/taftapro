class AnswersController < ApplicationController
	def create
		answer = Answer.new(answer_params)

		answer.save
			
	end  

	def find_or_create_client
		answer = Answer.new(answer_params)
		answer.save

		# This answer should contain the client's email
		client = Client.find_or_create_by(email: answer.answer)
		client_login(client)

		answers = Answer.where(client_token: answer.client_token)
		answers.each do |answer|
			answer.update_attribute(:client_id, client.id)
		end
	end

	private

		def answer_params
			params.require(:answer).permit(:answer, :question_id, :client_id, :client_token)
		end
end
