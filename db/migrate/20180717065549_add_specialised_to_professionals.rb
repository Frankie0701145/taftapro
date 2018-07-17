class AddSpecialisedToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :specialised, :string
  end
end
