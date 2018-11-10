# frozen_string_literal: true

class AddQuotationDocumentToQuotations < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :quotation_document, :string
  end
end
