class AddCareerStartDateToProfessionals < ActiveRecord::Migration[5.2]
  def change
    add_column :professionals, :career_start_date, :date
  end
end
