json.array!(@meslist) do |json, message|
  json.id message.id
  json.sender_id message.sender_id
  json.text message.text
  json.receiver_id message.receiver_id
  json.created_at message.created_at
  json.sender_name User.find(message.sender_id).name
  json.receiver_name User.find(message.receiver_id).name
  json.read message.read
  json.header message.header
  json.updated_at message.updated_at
  json.readers message.readers
end