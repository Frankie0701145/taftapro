class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :client_id
      t.integer :project_id
      t.decimal :amount, precision:10, scale:2

      t.timestamps
    end
  end
end
