class AddTextToBills < ActiveRecord::Migration
  def change
    add_column :bills, :text, :string
  end
end
