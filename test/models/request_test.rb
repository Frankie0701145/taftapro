# == Schema Information
#
# Table name: requests
#
#  id          :integer          not null, primary key
#  description :text
#  first_name  :string
#  last_name   :string
#  location    :string
#  service     :string
#  user_email  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
