class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :email
      t.string   :password
      t.string   :address
      t.string   :phone
      t.datetime :date_of_birth
      t.string   :gender
      t.string   :type

      t.timestamps
    end
  end
end
