json.array!(@catName) do |json, finance|
	json.cat_name finance.name
  	json.listValue @name[finance.name]
end