class AddPhoneNumberToProffessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :phone_number, :string
  end
end
