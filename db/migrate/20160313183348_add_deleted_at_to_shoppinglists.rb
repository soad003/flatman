class AddDeletedAtToShoppinglists < ActiveRecord::Migration
  def change
    add_column :shoppinglists, :deleted_at, :datetime
    add_index :shoppinglists, :deleted_at
  end
end
