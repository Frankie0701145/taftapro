# frozen_string_literal: true

class RemoveTypeFromQuestions < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :type, :string
  end
end
