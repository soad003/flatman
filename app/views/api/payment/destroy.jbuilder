json.name @response.name
json.value @response.value
json.img_path @response.img_path
json.id @response.id
json.entryLength @response.entryLength

json.entries @response.entries do |entry|
	json.(entry, :what, :id, :date, :value)
end
