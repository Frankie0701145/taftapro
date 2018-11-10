# frozen_string_literal: true

class AddPasswordDigestToProfessional < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :password_digest, :string
  end
end
