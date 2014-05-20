class AddReadersToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :readers, :integer, array: true, default: []
  end
end
