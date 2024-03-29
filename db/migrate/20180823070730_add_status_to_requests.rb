# frozen_string_literal: true

class AddStatusToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :status, :string, default: "Not Sent"
  end
end
