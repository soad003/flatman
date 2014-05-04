class ChangeShareditems < ActiveRecord::Migration
  def change
    change_column :shareditems, :available, :boolean, :default => true
    change_column :shareditems, :hidden, :boolean, :default => false
  end
end


