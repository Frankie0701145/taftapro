class RemoveSubCategoriesFromServiceCategories < ActiveRecord::Migration[5.2]
  def change
  	remove_column :service_categories, :sub_categories, :string
  end
end
