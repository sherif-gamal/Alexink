class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.integer :raw_material_id
      t.string :user_name
      t.float :quantity
      t.integer :permission_id

      t.timestamps null: false
    end
  end
end
