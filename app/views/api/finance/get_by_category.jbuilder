json.array!(@catName) do |finance|
	json.cat_name finance.name
  	json.listValue @name[finance.name]
end
