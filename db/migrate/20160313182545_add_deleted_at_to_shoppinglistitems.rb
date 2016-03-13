class AddDeletedAtToShoppinglistitems < ActiveRecord::Migration
  def change
    add_column :shoppinglistitems, :deleted_at, :datetime
    add_index :shoppinglistitems, :deleted_at
  end
end
