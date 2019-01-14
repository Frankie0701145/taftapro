class AddPictureToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :picture, :string
  end
end
