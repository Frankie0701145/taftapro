# frozen_string_literal: true

class RemoveFirstNameFromRequest < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :first_name, :string
  end
end
