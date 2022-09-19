class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.integer :sub_category_id
      t.integer :category_id 

      t.timestamps
    end
  end
end
