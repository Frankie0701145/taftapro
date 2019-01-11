class AddPesapalStatusToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :pesapal_status, :string
  end
end
