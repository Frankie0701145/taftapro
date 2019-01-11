class AddAmountToQuotation < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :amount, :decimal, precision: 10, scale: 2
  end
end
