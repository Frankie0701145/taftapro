class AddProfessionalIdToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :professional_id, :integer
  end
end
