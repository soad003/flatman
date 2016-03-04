class CreateTodoItem < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
    	t.string 		:name
    	t.boolean 		:checked
    	t.belongs_to	:user
    	t.belongs_to 	:todo
    	t.timestamps
    end
  end
end
