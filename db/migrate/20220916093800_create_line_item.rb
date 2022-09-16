class CreateLineItem < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.integer :Item_id
      t.integer :order_id
      t.text :action
      t.integer :quantity

      t.timestamps
    end
  end
end
