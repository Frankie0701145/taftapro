class AddProfessionalUniquessCommentToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :uniqueness_comment, :text
  end
end
