class AddClientTokenToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :client_token, :string
    add_index :answers, :client_token, unique: true
  end
end
