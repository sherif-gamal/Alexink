class CreateProductExpenses < ActiveRecord::Migration
  def change
    create_table :product_expenses do |t|
      t.integer :product_id
      t.float 	:constant_expense
      t.float	:raw_material_expense
      t.float	:employment
      t.float	:other

      t.timestamps null: false
    end
  end
end
