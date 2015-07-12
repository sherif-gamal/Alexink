class CreateTreasuryDiaries < ActiveRecord::Migration
  def change
    create_table :treasury_diaries do |t|
      t.integer :transaction_id
      t.integer :transaction_type
      # 1 = Material, 2 = Purchase, 3 = Supplier, 4 = Client, 5 = Manual, 6 = Expense
      t.integer :is_tax
      t.float :amount
      t.string :description
      t.string :cheque_num

      t.timestamps null: false
    end
  end
end
