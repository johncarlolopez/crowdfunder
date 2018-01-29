class CreateProgresses < ActiveRecord::Migration[5.1]
  def change
    create_table :progresses do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end