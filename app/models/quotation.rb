# == Schema Information
#
# Table name: quotations
#
#  id              :integer          not null, primary key
#  details         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  professional_id :integer
#
# Indexes
#
#  index_quotations_on_professional_id  (professional_id)
#

class Quotation < ApplicationRecord
  # belongs_to :professional
end
