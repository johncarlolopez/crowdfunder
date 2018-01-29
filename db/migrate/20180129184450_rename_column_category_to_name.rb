class RenameColumnCategoryToName < ActiveRecord::Migration[5.1]
  def up
    rename_column :categories, :category, :name
  end

  def down
    rename_column :categories, :name, :category
  end
end
