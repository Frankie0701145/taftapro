# frozen_string_literal: true

class AddProfessionalReferencesToRequest < ActiveRecord::Migration[5.2]
  def change
    add_reference :requests, :professional, foreign_key: true
  end
end
