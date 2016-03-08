class AddPlatformToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :platform, :string, default: 'android'
  end
end
