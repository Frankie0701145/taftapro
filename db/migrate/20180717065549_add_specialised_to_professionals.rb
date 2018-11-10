# frozen_string_literal: true

class AddSpecialisedToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :specialised, :string
  end
end
