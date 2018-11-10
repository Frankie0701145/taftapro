# frozen_string_literal: true

class AddIndexToClientsEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :clients, :email, unique: true
  end
end
