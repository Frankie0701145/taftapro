class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer :client_id
      t.integer :professional_id
      t.string :status
      t.integer :quotation_id
      t.datetime :due

      t.timestamps
    end
  end
end
