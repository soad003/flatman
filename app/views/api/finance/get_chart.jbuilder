json.array!(@chart) do |json,entry|
	json.c_name entry.billcategory.name
	json.value entry.value
end
