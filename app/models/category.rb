# frozen_string_literal: true
# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  service    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  has_many :questions, dependent: :destroy

  before_save :downcase_service

  def self.inputter(category_name, arr_services, arr_questions)
    puts "*** Creating services for category: #{category_name}... ***"

    arr_services.each do |service|
      puts "Creating #{service} service"
      service_category = Category.find_or_create_by(name: category_name, service: service)

      next unless service_category

      arr_questions.each do |question_obj|
        question_one =
          Question.find_by(
            question: question_obj["question".to_sym],
            category_id: service_category.id
          ) ||
          service_category.questions.build(question: question_obj["question".to_sym], answer_type: question_obj["answer_type".to_sym])
      end

      puts "#{service} service created." if service_category.save
    end
  end

  private

    def downcase_service
      service.downcase!
    end
end
