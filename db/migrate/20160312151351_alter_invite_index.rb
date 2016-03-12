class AlterInviteIndex < ActiveRecord::Migration
  def change
  	remove_index :invites, :email
  	add_index :invites, :email, unique: false
  end
end
