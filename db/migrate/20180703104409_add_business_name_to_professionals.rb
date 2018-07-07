class AddBusinessNameToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :business_name, :string
  end
end
