# == Schema Information
#
# Table name: service_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  service    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class Service::CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
