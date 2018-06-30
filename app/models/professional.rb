# == Schema Information
#
# Table name: professionals
#
#  id              :integer          not null, primary key
#  city            :string
#  country         :string
#  email           :string
#  first_name      :string
#  last_name       :string
#  latitude        :float
#  longitude       :float
#  password_digest :string
#  reset_digest    :string
#  reset_sent_at   :datetime
#  service         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Professional < ApplicationRecord

	before_save :downcase_email
	validates :first_name, :last_name, :email, :city, :country, :service, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					format: { with: VALID_EMAIL_REGEX },
					uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
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

	#private methods placed hear
	private
	#method to convert email to lower case
	def downcase_email
		email.downcase!
	end
end
