class CreateRawMaterials < ActiveRecord::Migration
  def change
    create_table :raw_materials do |t|
      t.string  :name
      t.string  :unit
      t.text    :description
      t.integer :in_stock

      t.timestamps null: false
    end
  end
end
