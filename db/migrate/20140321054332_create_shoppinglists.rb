class CreateShoppinglists < ActiveRecord::Migration
  def change
    create_table :shoppinglists do |t|
		t.string 	:name
    	t.belongs_to :flat
      t.timestamps
    end
  end
end
