# frozen_string_literal: true

class AddProfessionalIdToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :professional_id, :integer
  end
end
