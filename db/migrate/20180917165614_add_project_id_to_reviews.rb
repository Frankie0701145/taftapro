class AddProjectIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :project_id, :integer
  end
end
