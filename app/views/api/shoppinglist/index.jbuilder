json.array!(@sl) do |list|
  json.name list.name
  json.id list.id
  json.items list.shoppinglistitems do |item|
    json.(item , :id, :name, :checked, :created_at)
    json.created_by item.user.name if not item.user.nil?
  end
  json.type 'shop'
  json.private !list.user.nil?
end
