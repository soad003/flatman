json.array!(@sl) do |json, list|
  json.name list.name
  json.id list.id
  json.items list.shoppinglistitems do |json, item|
    json.(item , :id, :name, :checked)
  end
end
