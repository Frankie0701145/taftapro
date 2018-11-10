# frozen_string_literal: true

class RemoveDescriptionFromRequest < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :description, :text
  end
end
