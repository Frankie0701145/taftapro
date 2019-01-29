class AddGooglePictureUrlToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :google_picture_url, :string
  end
end
