# frozen_string_literal: true

class AddRequestIdToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :request_id, :integer
  end
end
