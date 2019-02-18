class AddTransIdAndTransTimeToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :trans_id, :string
    add_column :payments, :trans_time, :datetime
  end
end
