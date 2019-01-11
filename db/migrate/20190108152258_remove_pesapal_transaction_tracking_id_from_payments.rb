class RemovePesapalTransactionTrackingIdFromPayments < ActiveRecord::Migration[5.2]
  def change
  	remove_column :payments, :pesapal_transaction_tracking_id, :integer
  end
end
