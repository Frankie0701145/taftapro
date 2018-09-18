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
#  project_id      :integer
#

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
