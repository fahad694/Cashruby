class CreateOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.decimal :total_price
      t.integer :discount
      t.decimal :discounted_value
      t.decimal :after_discount
      t.string :state

      t.timestamps
    end
  end
end
