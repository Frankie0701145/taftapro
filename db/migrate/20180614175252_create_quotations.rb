# frozen_string_literal: true

class CreateQuotations < ActiveRecord::Migration[5.2]
  def change
    create_table :quotations do |t|
      t.string :details
      t.references :professional, foreign_key: true

      t.timestamps
    end
  end
end
