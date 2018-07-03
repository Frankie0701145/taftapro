# == Schema Information
#
# Table name: professionals
#
#  id                 :integer          not null, primary key
#  business_name      :string
#  city               :string
#  country            :string
#  email              :string
#  first_name         :string
#  last_name          :string
#  latitude           :float
#  longitude          :float
#  password_digest    :string
#  reset_digest       :string
#  reset_sent_at      :datetime
#  service            :string
#  uniqueness_comment :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Professional < ApplicationRecord
	attr_accessor :reset_token

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

	#Returns a random token
	def Professional.new_token
		SecureRandom.urlsafe_base64
	end

	# Returns the hash digest of the given string.
	def Professional.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
	#Sets the password reset attributes and saves it to the client model
	def create_reset_digest
		self.reset_token = Professional.new_token
		update_attribute(:reset_digest, Professional.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end
	# Sends password reset email.
	def send_password_reset_email
			ProfessionalMailer.password_reset(self).deliver_now
	end
	# Returns true if the given token matches the digest.
	def authenticated?(attribute, token)

		digest = self.send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)

	end
	# Returns true if a password reset has expired.
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	#private methods placed hear
	private
	#method to convert email to lower case
	def downcase_email
		email.downcase!
	end
end
