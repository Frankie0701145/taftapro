# == Schema Information
#
# Table name: quotations
#
#  id                 :integer          not null, primary key
#  details            :string
#  quotation_document :string
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

class Quotation < ApplicationRecord
  # belongs_to :professional
  	mount_uploader :quotation_document, QuotationDocumentUploader
end
