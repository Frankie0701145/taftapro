# == Schema Information
#
# Table name: payments
#
#  id                              :integer          not null, primary key
#  amount                          :decimal(10, 2)
#  mpesa_status                    :string
#  msisdn                          :string
#  payment_type                    :string
#  pesapal_status                  :string
#  status                          :integer
#  trans_time                      :datetime
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  client_id                       :integer
#  pesapal_transaction_tracking_id :string
#  professional_id                 :integer
#  project_id                      :integer
#  trans_id                        :string
#

require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
