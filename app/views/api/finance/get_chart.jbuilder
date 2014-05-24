json.array!(@chart) do |entry|
	json.c_name entry.billcategory.name
	json.value entry.value
end
