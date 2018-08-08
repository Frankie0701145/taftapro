class AddRequestReferencesToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :request, foreign_key: true
  end
end
