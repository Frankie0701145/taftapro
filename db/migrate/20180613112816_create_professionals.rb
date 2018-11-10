# frozen_string_literal: true

class CreateProfessionals < ActiveRecord::Migration[5.2]
  def change
    create_table :professionals do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :country
      t.string :email
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
