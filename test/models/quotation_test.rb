# frozen_string_literal: true
# == Schema Information
#
# Table name: quotations
#
#  id                 :integer          not null, primary key
#  amount             :decimal(10, 2)
#  details            :string
#  quotation_document :string
#  status             :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  client_id          :integer
#  professional_id    :integer
#  request_id         :integer
#
# Indexes
#
#  index_quotations_on_professional_id  (professional_id)
#

require "test_helper"

class QuotationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
