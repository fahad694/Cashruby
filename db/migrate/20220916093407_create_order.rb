class CreateOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.decimle :total_price
      t.integer :discount
      t.decimle :discounted_value
      t.decimle :after_discount
      t.number :state

      t.timestamps
    end
  end
end
