class AddPaidToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :paid, :decimal, precision: 10, scale: 2, default:0.00, null:false
  end
end
