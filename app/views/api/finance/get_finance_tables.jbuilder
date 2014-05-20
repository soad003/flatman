json.array!(@userTables) do |member_info|
  json.name member_info.name
  json.value member_info.value
 

  json.entries member_info.entries do |entry|
    json.(entry, :what, :date, :value)
  end
end