json.array!(@meslist) do |json, chat|
  json.id chat.id
  json.sender_id chat.sender_id
  json.text chat.text
  json.receiver_id chat.receiver_id
  json.time chat.created_at
  json.sender_name chat.sender.name
  json.receiver_name chat.receiver.name
  json.header chat.header
  if chat.receiver_id == current_user.id
    json.flat_name Flat.find(chat.sender.flat_id).name
  	json.partner chat.sender.name
  	json.partner_id chat.sender.id
  else
  	json.partner chat.receiver.name
  	json.partner_id chat.receiver.id
    json.flat_name Flat.find(chat.receiver.flat_id).name
  end
end