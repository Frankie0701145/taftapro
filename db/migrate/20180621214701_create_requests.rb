# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.text :description
      t.string :user_email
      t.string :first_name
      t.string :last_name
      t.string :service
      t.string :location

      t.timestamps
    end
  end
end
