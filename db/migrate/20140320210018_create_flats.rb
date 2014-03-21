class CreateFlats < ActiveRecord::Migration
  def change
    create_table :flats do |t|
		t.string 		:name
    	t.string 		:street
    	t.string 		:city
    	t.string 		:zip
    	t.string 		:image_path
      t.timestamps
    end
  end
end
