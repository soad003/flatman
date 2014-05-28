json.name @userTable.name
json.value @userTable.value
json.img_path @userTable.img_path
json.id @userTable.id
json.entryLength @userTable.entryLength
json.entries @userTable.entries do |entry|
	json.(entry, :what, :id, :date, :value)
end
