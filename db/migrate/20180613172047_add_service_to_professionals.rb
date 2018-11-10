# frozen_string_literal: true

class AddServiceToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :service, :string
  end
end
