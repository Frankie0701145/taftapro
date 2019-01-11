class AddPhoneNumberToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :phone_number, :string
  end
end
