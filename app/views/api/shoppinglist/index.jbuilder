json.array!(@sl) do |list|
  json.name list.name
  json.id list.id
  json.items list.shoppinglistitems do |item|
    json.(item , :id, :name, :checked)
  end
end
