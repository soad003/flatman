json.array!(@meslist) do |json, message|
  json.id message.id
  json.sender message.sender_id
  json.text message.text
  json.receiver message.receiver_id
  json.time message.created_at
  json.sender_name User.find(message.sender_id).name
  json.receiver_name User.find(message.receiver_id).name
end