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

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
