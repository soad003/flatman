class AddPushFlagToUsers < ActiveRecord::Migration
  def change
	add_column :users, :pushflag, :boolean, default: true
  end
end
