class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string 	:name
      t.string 	:unit
      t.float 	:quantity
      t.float 	:price_per_unit
      t.integer	:in_stock
      t.text    :description
      t.integer :permission_id

      t.timestamps null: false
    end
  end
end
