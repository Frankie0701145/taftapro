# == Schema Information
#
# Table name: service_categories
#
#  id             :integer          not null, primary key
#  name           :string
#  sub_categories :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Service::Category < ApplicationRecord
  has_many :questions


  def self.create_home_improvement_category
		home_improvement_category = Service::Category.find_or_create_by(name: "Home Improvement")    
		
		question_one = 
			Question.find_by(question: "Where do you need the service?", category_id: home_improvement_category.id) || home_improvement_category.questions.build(question: "Where do you need the service?")
		question_two = home_improvement_category.questions.build(question: "Describe the nature of the service.")
		question_three = home_improvement_category.questions.build(question: "Describe the nature of the service.")

		home_improvement_category.save
  end

  def self.home_improvement_category
  	home_improvement_category = Service::Category.where(name: "Home Improvement")    
  	home_improvement_category[0]
  end
end
