json.array!(@meslist) do |chat|
  json.id chat.id
  json.sender_id chat.sender_id
  json.text chat.text
  json.receiver_id chat.receiver_id
  json.time chat.created_at
  json.sender_name chat.sender.name
  json.receiver_name chat.receiver.name
  json.header chat.header
  if chat.receiver_id == current_user.id
    if chat.sender.flat_id != nil
      json.flat_name Flat.find(chat.sender.flat_id).name
    end
  	json.partner chat.sender.name
  	json.partner_id chat.sender.id
  else
  	json.partner chat.receiver.name
  	json.partner_id chat.receiver.id
    if chat.receiver.flat_id != nil
      json.flat_name Flat.find(chat.receiver.flat_id).name
    end
  end
end