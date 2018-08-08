# == Schema Information
#
# Table name: requests
#
#  id              :integer          not null, primary key
#  location        :string
#  service         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :integer
#  professional_id :integer
#
# Indexes
#
#  index_requests_on_client_id        (client_id)
#  index_requests_on_professional_id  (professional_id)
#

class Request < ApplicationRecord
  has_many   :answers
  #has_many   :questions
end
