# frozen_string_literal: true

class AddResetToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :reset_digest, :string
    add_column :clients, :reset_sent_at, :datetime
  end
end
