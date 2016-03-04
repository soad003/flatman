class CreateTodo < ActiveRecord::Migration
  def change
    create_table :todos do |t|
    	t.string 	:name
    	t.belongs_to :flat
      	t.timestamps
    end
  end
end
