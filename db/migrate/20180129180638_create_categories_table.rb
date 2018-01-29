class CreateCategoriesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :category, :category, :name
    end
  end
end
