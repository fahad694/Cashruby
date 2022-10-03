class AddIndexToLineItems < ActiveRecord::Migration[6.1]
  def change
    add_index :line_items, :item_id
    add_index :line_items, :order_item_id
  end
end
