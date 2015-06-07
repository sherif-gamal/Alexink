class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string 	:name
      t.integer :supplier_id
      t.string 	:unit
      t.float 	:quantity
      t.float 	:price
      t.string	:payment_method
      t.string	:payment_state
      t.float   :debt
      t.string	:state
      t.integer :in_stock

      t.timestamps null: false
    end

    add_index :materials, :supplier_id
  end
end
