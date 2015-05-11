class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.float 	:quantity
      t.float 	:price
      t.string 	:client
      t.string	:payment_method
      t.string	:payment_state
      t.string	:state

      t.timestamps null: false
    end
  end
end
