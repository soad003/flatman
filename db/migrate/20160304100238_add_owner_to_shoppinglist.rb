class AddOwnerToShoppinglist < ActiveRecord::Migration
  def change
  	add_reference :shoppinglists, :user, index: true, foreign_key: true
  end
end
