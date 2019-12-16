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
  def setup
    @quotation = Quotation.new(:amount=>"1,000")
  end
  #the amount should not contain commas
  test "amount should not contain commas" do
      assert_not @quotation.valid?
  end
  #the amount should not contain words should only contain figures
  test "amount should not contain only figures" do
    quotation3 = Quotation.new(:amount=>"One hundred thousand")
    assert_not quotation3.valid?
  end
  #the amount should not contain symbol should only contain figures
  test "amount should not contain only currency symbols" do
    quotation4 = Quotation.new(:amount=>"1000$")
    assert_not quotation4.valid?
  end
  # the amount field should be not empty
  test "amount should not be empty" do
    quotation2 = Quotation.new(:amount=>'')
    assert_not quotation2.valid?
  end
end
