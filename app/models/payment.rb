# == Schema Information
#
# Table name: payments
#
#  id                              :integer          not null, primary key
#  amount                          :decimal(10, 2)
#  payment_type                    :string
#  pesapal_status                  :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  client_id                       :integer
#  pesapal_transaction_tracking_id :integer
#  professional_id                 :integer
#  project_id                      :integer
#

class Payment < ApplicationRecord
end
