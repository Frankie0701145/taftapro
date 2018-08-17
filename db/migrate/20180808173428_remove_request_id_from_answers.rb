class RemoveRequestIdFromAnswers < ActiveRecord::Migration[5.2]
  def change
    remove_column :answers, :request_id, :integer
  end
end
