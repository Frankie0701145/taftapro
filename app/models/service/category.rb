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
  	@@home_improvement_services.each do |home_improvement_service|
	    home_improvement_category = Service::Category.find_or_create_by(name: "Home Improvement", service: home_improvement_service)    
	    
	    if home_improvement_category
	      question_one = 
	        Question.find_by(
	        	question: "Where do you need the service?", 
	        	category_id: home_improvement_category.id
	        	) || 
	        home_improvement_category.questions.build(question: "Where do you need the service?")

	      question_two = 
	        Question.find_by(
	        	question: "Describe the nature of the service.", 
	        	category_id: home_improvement_category.id
	        	) ||       	
	      	home_improvement_category.questions.build(question: "Describe the nature of the service.")

	      home_improvement_category.save
	    end
    end
  end

  def self.home_improvement_category
  	Service::Category.find_by(name: "Home Improvement")    
  end
end
