class CreateShoppinglistitems < ActiveRecord::Migration
  def change
    create_table :shoppinglistitems do |t|
  		t.string 		:name
    	t.boolean 		:checked
    	t.belongs_to	:user
    	t.belongs_to 	:shoppinglist
      t.timestamps
    end
  end
end
