# == Schema Information
#
# Table name: quotations
#
#  id                 :integer          not null, primary key
#  details            :string
#  quotation_document :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  professional_id    :integer
#
# Indexes
#
#  index_quotations_on_professional_id  (professional_id)
#

require 'test_helper'

class QuotationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
