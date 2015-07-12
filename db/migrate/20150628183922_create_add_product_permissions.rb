class CreateAddProductPermissions < ActiveRecord::Migration
  def change
    create_table :add_product_permissions do |t|
      t.integer :transaction_id
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
