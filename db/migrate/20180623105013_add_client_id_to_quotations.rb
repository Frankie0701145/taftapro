# frozen_string_literal: true

class AddClientIdToQuotations < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :client_id, :integer
  end
end
