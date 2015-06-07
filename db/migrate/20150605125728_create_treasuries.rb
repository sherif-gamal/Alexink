class CreateTreasuries < ActiveRecord::Migration
  def change
    create_table :treasuries do |t|
      t.integer :bank
      t.integer :cash

      t.timestamps null: false
    end
  end
end
