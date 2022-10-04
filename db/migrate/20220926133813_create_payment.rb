class CreatePayment < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.decimal :paid_amount

      t.timestamps
    end
  end
end
