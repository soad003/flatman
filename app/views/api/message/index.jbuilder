json.array!(@meslist) do |json, chat|
  json.id chat.id
  json.sender_id chat.sender_id
  json.text chat.text
  json.receiver_id chat.receiver_id
  json.time chat.created_at
  json.sender_name User.find(chat.sender_id).name
  json.receiver_name User.find(chat.receiver_id).name
  json.header chat.header
  if chat.receiver_id == current_user.id
  	json.partner User.find(chat.sender_id).name
  	json.partner_id User.find(chat.sender_id).id
  else
  	json.partner User.find(chat.receiver_id).name
  	json.partner_id User.find(chat.receiver_id).id
  end
end