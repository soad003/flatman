class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
    	t.float 		:value		
    	t.datetime		:date
    	t.belongs_to 	:user
    	t.belongs_to 	:billcategory

      t.timestamps
    end
  end
end
