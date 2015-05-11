class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string 	:name
      t.string 	:unit
      t.float 	:quantity
      t.float 	:price
      t.string 	:seller
      t.string	:payment_method
      t.string	:payment_state
      t.string	:state

      t.timestamps null: false
    end
  end
end
