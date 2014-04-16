class AddIndexToInvite < ActiveRecord::Migration
  def change
    add_index :invites, :email, unique: true
  end
end
