class CreateEhlakOsools < ActiveRecord::Migration
  def change
    create_table :ehlak_osools do |t|
      t.string  :name
      t.float	:rate
      t.float	:value
      t.float	:last_year_acc
      t.integer	:year

      t.timestamps null: false
    end
  end
end
