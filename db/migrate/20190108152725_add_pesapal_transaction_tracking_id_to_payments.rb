class AddPesapalTransactionTrackingIdToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :pesapal_transaction_tracking_id, :string
  end
end
