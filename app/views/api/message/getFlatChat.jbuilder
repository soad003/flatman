json.id @lastFlatChat.id
json.sender_id @lastFlatChat.sender_id
json.text @lastFlatChat.text
json.time @lastFlatChat.created_at
json.sender_name User.find(@lastFlatChat.sender_id).name
json.header @lastFlatChat.header
json.flat_name Flat.find(User.find(@lastFlatChat.sender_id).flat_id).name