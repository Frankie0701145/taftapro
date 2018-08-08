# == Schema Information
#
# Table name: requests
#
#  id         :integer          not null, primary key
#  location   :string
#  service    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Request < ApplicationRecord
  belongs_to :professional
  belongs_to :client
  has_many   :answer
end
