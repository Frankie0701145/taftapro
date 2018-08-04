# == Schema Information
#
# Table name: service_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  service    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Service::Category < ApplicationRecord
  has_many :questions


  @@home_improvement_services = ["Domestic", 
								"Workers",
								"Handy Man",
								"House Cleaning",
								"Car Cleaning",
								"Interior Design",
								"General Contracting",
								"Repair and Maintenance",
								"Plumbing",
								"Landscaping",
								"Electrical",
								"Home Painting",
								"Home remodeling",
								"Carpet cleaning",
								"Lawn mowing",
								"Laundry"]

  def self.create_home_improvement_category
  	first_question = { question: "Describe the nature of the service.", answer_type: "text_area" }
  	second_question = { question: "Which additional service do you want if any?", answer_type: "text_field" }
  	third_question = { question: "When do you need this service done – calendar?", answer_type: "date_field" }
  	last_question = { question: "Where can we send your matches?", answer_type: "email_field" }

  	@@home_improvement_services.each do |home_improvement_service|
	    home_improvement_category = Service::Category.find_or_create_by(name: "Home Improvement", service: home_improvement_service)    
	    
	    if home_improvement_category
	      question_one = 
	        Question.find_by(
	        	question: first_question["question".to_sym], 
	        	category_id: home_improvement_category.id
	        	) || 
	        home_improvement_category.questions.build(question: first_question["question".to_sym], answer_type: first_question["answer_type".to_sym])

	      question_two = 
	        Question.find_by(
	        	question: second_question["question"], 
	        	category_id: home_improvement_category.id
	        	) ||       	
	      	home_improvement_category.questions.build(question: second_question["question".to_sym], answer_type: second_question["answer_type".to_sym])

		  question_three = 
	        Question.find_by(
	        	question: third_question["question"], 
	        	category_id: home_improvement_category.id
	        	) ||       	
	      	home_improvement_category.questions.build(question: third_question["question".to_sym], answer_type: third_question["answer_type".to_sym])

	      question_last = 
	        Question.find_by(
	        	question: last_question["question"], 
	        	category_id: home_improvement_category.id
	        	) ||       	
	      	home_improvement_category.questions.build(question: last_question["question".to_sym], answer_type: last_question["answer_type".to_sym])	      

	      home_improvement_category.save
	    end
    end
  end

  def self.home_improvement_category
  	Service::Category.find_by(name: "Home Improvement")    
  end
end
