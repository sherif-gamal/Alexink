class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string 	:name
      t.float 	:price
      t.string 	:seller
      t.string	:payment_method
      t.string	:payment_state
      t.float   :debt

      t.timestamps null: false
    end
  end
end
