class ChangeNewsitems < ActiveRecord::Migration
  def change
     change_column :newsitems, :action, :string
     change_column :newsitems, :category, :string
  end
end
