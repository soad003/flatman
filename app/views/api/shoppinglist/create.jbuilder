json.name @sl.name
json.id @sl.id
json.items @sl.shoppinglistitems do |item|
	json.(item , :id, :name, :checked, :created_at)
	json.created_by item.user.name if not item.user.nil?
end
json.type 'shop'
json.private !@sl.user.nil?