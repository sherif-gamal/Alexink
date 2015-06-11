class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :transaction_type
       # 1 = add material, 2 = release material, 3 = add product, 4 release product
       # 5 = release money for material, 6 = release money for expense
      t.integer :transaction_id
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
