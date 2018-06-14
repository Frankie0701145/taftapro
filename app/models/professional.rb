# == Schema Information
#
# Table name: professionals
#
#  id         :integer          not null, primary key
#  city       :string
#  country    :string
#  email      :string
#  first_name :string
#  last_name  :string
#  latitude   :float
#  longitude  :float
#  service    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Professional < ApplicationRecord
	validates :first_name, :last_name, :email, :city, :country, presence: true
	geocoded_by :address
	after_validation :geocode, if: :address_changed?
	has_one :quotation

	def full_name
		"#{first_name} #{last_name}"
	end
	
	def address
		[city, country].compact.join(", ")
	end

	def address_changed?
		city_changed? || country_changed?
	end
end
