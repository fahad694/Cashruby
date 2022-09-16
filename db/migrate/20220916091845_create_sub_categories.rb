class CreateSubCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :sub_categories do |t|
      t.string :title
      t.integer :categories_id

      t.timestamps
    end
  end
end
