# == Schema Information
#
# Table name: reviews
#
#  id              :integer          not null, primary key
#  comment         :text
#  rating          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :integer
#  professional_id :integer
#

class Review < ApplicationRecord
  belongs_to :professional, dependent: :destroy
  belongs_to :client, dependent: :destroy
end
