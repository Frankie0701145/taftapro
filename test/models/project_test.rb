# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  due             :datetime
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :integer
#  professional_id :integer
#  quotation_id    :integer
#

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
