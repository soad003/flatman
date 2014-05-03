class ChangeColumnsShareditem < ActiveRecord::Migration
  def change
    change_column :shareditems, :available, :boolean, :default => false
  end
end
