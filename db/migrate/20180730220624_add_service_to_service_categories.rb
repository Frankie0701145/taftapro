class AddServiceToServiceCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :service_categories, :service, :string
  end
end
