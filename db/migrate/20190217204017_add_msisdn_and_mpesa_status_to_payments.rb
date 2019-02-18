class AddMsisdnAndMpesaStatusToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :msisdn, :string
    add_column :payments, :mpesa_status, :string
  end
end
