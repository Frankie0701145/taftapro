# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_clients_on_email  (email) UNIQUE
#

class Client < ApplicationRecord
	validates :name, :email, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					format: { with: VALID_EMAIL_REGEX },
					uniqueness: { case_sensitive: false }	
end
