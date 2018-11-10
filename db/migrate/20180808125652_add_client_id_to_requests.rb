# frozen_string_literal: true

class AddClientIdToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :client_id, :integer
  end
end
