class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.varchar :email
      t.varchar :password
      t.string :address
      t.text :phone
      t.datetime :date_of_birth
      t.text :gender
      t.text :type

      t.timestamps
    end
  end
end
