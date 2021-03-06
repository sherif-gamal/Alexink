class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :occupation
      t.string :department
      t.string :address
      t.string :encrypted_password
      t.string :salt
      t.string :phone

      t.timestamps null: false
    end

    add_index :users, :email, :unique => true
  end
end
