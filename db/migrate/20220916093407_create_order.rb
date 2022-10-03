class CreateOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer  :customer_id
      t.decimal  :total_price
      t.integer  :discount_percentage
      t.decimal  :discounted_value
      t.decimal  :total_discount
      t.string   :state

      t.timestamps
    end
  end
end
