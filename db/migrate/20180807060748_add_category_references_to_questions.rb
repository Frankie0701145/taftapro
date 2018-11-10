# frozen_string_literal: true

class AddCategoryReferencesToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :category, foreign_key: true
  end
end
