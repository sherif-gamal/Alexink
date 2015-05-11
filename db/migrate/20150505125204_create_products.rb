class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string 	:name
      t.string 	:unit
      t.float 	:quantity
      t.float 	:price_per_unit
      t.string	:state

      t.timestamps null: false
    end
  end
end
