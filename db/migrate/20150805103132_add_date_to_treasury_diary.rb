class AddDateToTreasuryDiary < ActiveRecord::Migration
  def change
  	add_column :treasury_diaries, :date_added, :string
  end
end
