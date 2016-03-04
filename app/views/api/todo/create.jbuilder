json.name @todo.name
json.id @todo.id
json.items @todo.todo_items do |item|
	json.(item , :id, :name, :checked, :created_at)
	json.created_by item.user.name if not item.user.nil?
end
json.type 'todo'
json.private !@todo.user.nil?