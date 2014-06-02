class RenameRessourcesToResources < ActiveRecord::Migration
   def self.up
        rename_table :ressources, :resources
    end 
    def self.down
        rename_table :resources, :resources
    end
end
