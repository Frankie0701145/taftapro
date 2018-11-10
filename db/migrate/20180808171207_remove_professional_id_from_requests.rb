# frozen_string_literal: true

class RemoveProfessionalIdFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :professional_id, :integer
  end
end
