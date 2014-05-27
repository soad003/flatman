class AddDeletedToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :deleted, :integer, array: true, default: []
  end
end
