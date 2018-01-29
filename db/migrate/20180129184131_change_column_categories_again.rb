class ChangeColumnCategoriesAgain < ActiveRecord::Migration[5.1]
  def change
    change_column :categories, :category, :name
  end
end
