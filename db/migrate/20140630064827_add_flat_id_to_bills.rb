class AddFlatIdToBills < ActiveRecord::Migration
  def change
    add_column :bills, :flat_id, :integer
  end
end
