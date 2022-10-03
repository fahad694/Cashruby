class AddIndexToItems < ActiveRecord::Migration[6.1]
  def change
    add_index :items, :name
    add_index :items, :sub_category_id
    add_index :items, :category_id
  end

end
