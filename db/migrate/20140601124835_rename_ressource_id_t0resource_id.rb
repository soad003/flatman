class RenameRessourceIdT0resourceId < ActiveRecord::Migration
  def change
  	rename_column :resourceentries, :ressource_id, :resource_id
  end
end
