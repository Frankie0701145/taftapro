class AddBioToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :bio, :text
  end
end
