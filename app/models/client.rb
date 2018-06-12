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

class Client < ApplicationRecord
	validates :name, presence: true
end
