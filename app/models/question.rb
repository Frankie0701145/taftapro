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

class Question < ApplicationRecord
  belongs_to :category, :class_name => "Services::Category"
  has_many :answers

  validates :question, uniqueness: true
end
