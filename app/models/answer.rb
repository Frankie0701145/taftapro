# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  answer      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :integer
#  question_id :integer
#
# Indexes
#
#  index_answers_on_client_id    (client_id)
#  index_answers_on_question_id  (question_id)
#

class Answer < ApplicationRecord
  belongs_to :client
  belongs_to :question
end
