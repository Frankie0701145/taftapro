class RemovePictureUrlFromProfessionals < ActiveRecord::Migration[5.2]
  def change
  	remove_column :professionals, :picture_url, :string
  end
end
