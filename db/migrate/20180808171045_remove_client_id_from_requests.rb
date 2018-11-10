# frozen_string_literal: true

class RemoveClientIdFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :client_id, :integer
  end
end
