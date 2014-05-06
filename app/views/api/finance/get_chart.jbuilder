json.array!(@chart) do |json,entry|
	json.c_name Billcategory.find(entry.billcategory_id).name
	json.value entry.value
end