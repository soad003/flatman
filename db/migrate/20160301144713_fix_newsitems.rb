class FixNewsitems < ActiveRecord::Migration
   def self.up
    remove_column :newsitems, :header
    remove_column :newsitems, :newsitemcategory_id
    add_column    :newsitems, :type, :integer, default: 0
    add_column    :newsitems, :action, :integer, default: 0
    add_column    :newsitems, :key, :integer
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end