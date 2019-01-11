class AddStatusToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :status, :integer
  end
end
