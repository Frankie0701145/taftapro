class RemoveRequestIdFromRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :requests, :request_id, :integer
  end
end
