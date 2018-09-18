# == Schema Information
#
# Table name: clients
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  reset_digest    :string
#  reset_sent_at   :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_clients_on_email  (email) UNIQUE
#

class Client < ApplicationRecord

	has_many :answers,  :dependent=> :destroy
	has_many :reviews, :dependent=> :destroy

	attr_accessor :reset_token

	before_save :downcase_email
	# validates :first_name, :last_name, :email, presence: true, allow_nil: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					format: { with: VALID_EMAIL_REGEX },
					uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	def full_name
		"#{first_name} #{last_name}"
	end

	# Returns the hash digest of the given string.
	def Client.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def Client.create_password
		SecureRandom.hex(3)
	end

	# Returns a random token.
	def Client.new_token
			SecureRandom.urlsafe_base64
	end

	#Sets the password reset attributes and saves it to the client model
	def create_reset_digest
		self.reset_token = Client.new_token
		update_attribute(:reset_digest, Client.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	# Sends password reset email.
	def send_password_reset_email
			ClientMailer.password_reset(self).deliver_now
	end

	def request_quotation(professional: , request:, answers:)
		ClientMailer.quotation(self, professional: professional, request: request, answers:answers).deliver_now
	end
	def password_send(password)
		ClientMailer.password_send(self, password).deliver_now
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

	private

	def downcase_email
		email.downcase!
	end
end
