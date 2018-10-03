class AddProfessionalEmailToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :professional_email, :string
  end
end
