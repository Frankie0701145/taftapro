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


  def self.home_improvement
		home_improvement_category = Service::Category.create(name: "Home Improvement")    
		question_one = home_improvement_category.questions.build(question: "Where do you need the service?")
  end
end
