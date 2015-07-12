class CreateProductionPermissions < ActiveRecord::Migration
  def change
    create_table :production_permissions do |t|
      t.integer :transaction_id
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
