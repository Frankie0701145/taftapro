# frozen_string_literal: true

class RemoveUserEmailFromRequest < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :user_email, :string
  end
end
