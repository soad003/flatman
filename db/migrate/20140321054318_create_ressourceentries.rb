class CreateRessourceentries < ActiveRecord::Migration
  def change
    create_table :ressourceentries do |t|
    	t.belongs_to 		:ressource
    	t.datetime			:date
    	t.float				:value
      t.timestamps
    end
  end
end
