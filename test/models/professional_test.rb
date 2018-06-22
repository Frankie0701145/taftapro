# == Schema Information
#
# Table name: professionals
#
#  id              :integer          not null, primary key
#  city            :string
#  country         :string
#  email           :string
#  first_name      :string
#  last_name       :string
#  latitude        :float
#  longitude       :float
#  password_digest :string
#  service         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class ProfessionalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
