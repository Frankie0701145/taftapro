# frozen_string_literal: true

class AddClientReferencesToRequest < ActiveRecord::Migration[5.2]
  def change
    add_reference :requests, :client, foreign_key: true
  end
end
