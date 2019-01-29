class AddPictureUrlToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :picture_url, :string
  end
end
