class CreateAddMaterialPermissions < ActiveRecord::Migration
  def change
    create_table :add_material_permissions do |t|
      t.integer :transaction_id
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
