class AddTokenToFlat < ActiveRecord::Migration
  def change
  	add_column :flats, :token, :string
  end
end
