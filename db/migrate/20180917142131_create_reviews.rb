# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :client_id
      t.integer :professional_id
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
