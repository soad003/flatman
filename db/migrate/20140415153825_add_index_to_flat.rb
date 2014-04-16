class AddIndexToFlat < ActiveRecord::Migration
  def change
    add_index :flats, :name, unique: true
  end
end
