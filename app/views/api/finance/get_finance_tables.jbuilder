json.array!(@userTables) do |member_info|
  json.name member_info.name
  json.value member_info.value
  json.img_path member_info.img_path
  json.id member_info.id
  json.entries member_info.entries do |entry|
    json.(entry, :what, :date, :value)
  end
end