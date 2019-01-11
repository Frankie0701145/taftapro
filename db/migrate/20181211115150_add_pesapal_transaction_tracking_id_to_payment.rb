class AddPesapalTransactionTrackingIdToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :pesapal_transaction_tracking_id, :integer
  end
end
