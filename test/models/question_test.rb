# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  answer      :string
#  answer_type :string
#  question    :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#
# Indexes
#
#  index_questions_on_category_id  (category_id)
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
