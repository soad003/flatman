json.array!(@mesd) do |json, chat|
  json.id chat.id
  json.sender_id chat.sender_id
  json.text chat.text
  json.receiver_id chat.receiver_id
  json.time chat.created_at
  json.sender_name chat.sender.name
  json.receiver_name chat.receiver.name
end