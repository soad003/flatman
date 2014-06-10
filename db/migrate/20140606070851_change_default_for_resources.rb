class ChangeDefaultForResources < ActiveRecord::Migration
  def change
    change_column :resources, :monthlyCost, :float, default: 0
    change_column :resources, :annualCost, :float, default: 0
  end
end
