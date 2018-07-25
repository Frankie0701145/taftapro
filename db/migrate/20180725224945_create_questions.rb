class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :question
      t.string :type
      t.string :answer
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
