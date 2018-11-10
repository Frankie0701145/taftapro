# frozen_string_literal: true

class AddStatusToQuotations < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :status, :string
  end
end
