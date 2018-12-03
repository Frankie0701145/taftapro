# frozen_string_literal: true
# == Schema Information
#
# Table name: projects
#
#  id              :integer          not null, primary key
#  balance         :decimal(10, 2)   default(0.0), not null
#  due             :datetime
#  paid            :decimal(10, 2)   default(0.0), not null
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  client_id       :integer
#  professional_id :integer
#  quotation_id    :integer
#  request_id      :integer
#

require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
