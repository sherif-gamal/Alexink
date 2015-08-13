class ChangeDateFormatInTables < ActiveRecord::Migration
  def change
  	change_column :materials, :date_added, :date
  	change_column :purchases, :date_added, :date
  	change_column :expenses, :date_added, :date
  	change_column :productions, :date_added, :date
  	change_column :treasury_diaries, :date_added, :date
  end
end
