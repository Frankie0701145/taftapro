class AddResetToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :reset_digest, :string
    add_column :professionals, :reset_sent_at, :datetime
  end
end
