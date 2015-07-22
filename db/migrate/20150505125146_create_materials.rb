class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :raw_material_ids
      t.string  :quantities
      t.string  :prices
      t.float   :price
      t.integer :supplier_id
      t.string	:payment_method
      t.string	:payment_state
      t.float   :debt
      t.string	:state
      t.integer :in_stock
      t.string :user_name
      t.integer :permission_id
      t.integer :calc_sub_tax

      t.timestamps null: false
    end

    add_index :materials, :supplier_id
  end
end
