class CreateBillcategories < ActiveRecord::Migration
  def change
    create_table :billcategories do |t|
    	t.belongs_to 	:flat
    	t.string 		:name

      t.timestamps
    end
  end
end
