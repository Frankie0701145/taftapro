# frozen_string_literal: true

class AddRequestIdToQuotations < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :request_id, :integer
  end
end
