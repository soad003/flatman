class AddOwnerToTodos < ActiveRecord::Migration
  def change
  	add_reference :todos, :user, index: true, foreign_key: true
  end
end
