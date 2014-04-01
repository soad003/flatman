class AddIsFirstToRessourceentries < ActiveRecord::Migration
  def change
    add_column :ressourceentries, :isFirst, :boolean, :default => false
  end
end
