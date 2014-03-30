class CreateShareditems < ActiveRecord::Migration
  def change
    create_table :shareditems do |t|
		t.string 		:name
    	t.string		:tags
    	t.boolean		:available
      t.boolean   :hidden
    	t.string		:description
    	t.string		:sharingNote
    	t.string 		:image_path
    	t.belongs_to	:flat
      t.timestamps
    end
  end
end
