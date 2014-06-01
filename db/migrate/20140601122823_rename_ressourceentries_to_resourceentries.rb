class RenameRessourceentriesToResourceentries < ActiveRecord::Migration
    def self.up
        rename_table :ressourceentries, :resourceentries
    end
    def self.down
        rename_table :resourceentries, :resourceentries
    end
end