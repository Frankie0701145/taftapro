# frozen_string_literal: true

class AddSpecializationToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :specialization, :string
  end
end
