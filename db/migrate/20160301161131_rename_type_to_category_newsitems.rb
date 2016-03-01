class RenameTypeToCategoryNewsitems < ActiveRecord::Migration
   def self.up
        rename_column :newsitems, :type, :category
    end
    def self.down
    end
end