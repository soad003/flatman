json.name @overviewMate.name
json.value @overviewMate.value
json.img_path @overviewMate.img_path
json.id @overviewMate.id
json.entryLength @overviewMate.entryLength
json.entries @overviewMate.entries do |entry|
	json.(entry, :what, :id, :date, :value)
end
