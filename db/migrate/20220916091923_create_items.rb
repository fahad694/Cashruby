class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.double :price
      t.integer :quantity
      t.integer :sub_categories_id
      t.integer :categories_id 

      t.timestamps
    end
  end
end
