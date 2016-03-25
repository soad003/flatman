class ChangeDateToDatetimeInBills < ActiveRecord::Migration
  def change
  	change_column :bills, :date, :datetime
  end
end
