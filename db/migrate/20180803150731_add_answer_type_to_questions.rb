# frozen_string_literal: true

class AddAnswerTypeToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :answer_type, :string
  end
end
