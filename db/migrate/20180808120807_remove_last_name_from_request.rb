# frozen_string_literal: true

class RemoveLastNameFromRequest < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :last_name, :string
  end
end
