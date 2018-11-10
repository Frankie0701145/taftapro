# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id                 :integer          not null, primary key
#  answer             :string
#  client_token       :string
#  professional_email :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  client_id          :integer
#  question_id        :integer
#  request_id         :integer
#
# Indexes
#
#  index_answers_on_client_id    (client_id)
#  index_answers_on_question_id  (question_id)
#  index_answers_on_request_id   (request_id)
#

class Answer < ApplicationRecord
  belongs_to :question
  # belongs_to :request
end
