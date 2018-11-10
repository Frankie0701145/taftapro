# frozen_string_literal: true

class AddClientTokenToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :client_token, :string
  end
end
