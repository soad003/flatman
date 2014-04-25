class Shareditem < ActiveRecord::Migration
  def change
    add_column :shareditems, :hidden, :boolean, :default => false
    change_column :shareditems, :available, :boolean, :default => false
  end
end
