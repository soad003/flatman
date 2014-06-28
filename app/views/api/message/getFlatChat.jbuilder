json.id @lastFlatChat.id
json.sender_id @lastFlatChat.sender_id
json.text @lastFlatChat.text
json.time @lastFlatChat.created_at
json.sender_name @lastFlatChat.sender.name
json.header @lastFlatChat.header
if @lastFlatChat.sender.flat_id != nil
	json.flat_name Flat.find(@lastFlatChat.sender.flat_id).name
end