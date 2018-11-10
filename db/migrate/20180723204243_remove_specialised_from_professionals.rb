# frozen_string_literal: true

class RemoveSpecialisedFromProfessionals < ActiveRecord::Migration[5.2]
  def change
    remove_column :professionals, :specialised, :string
  end
end
