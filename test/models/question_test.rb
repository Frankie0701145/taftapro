# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  answer      :string
#  question    :text
#  type        :string
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
