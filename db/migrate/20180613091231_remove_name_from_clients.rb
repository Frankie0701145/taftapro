# frozen_string_literal: true

class RemoveNameFromClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :name
  end
end
