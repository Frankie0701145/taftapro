# frozen_string_literal: true

class AddRequestIdToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :request_id, :integer
  end
end
