json.id @mes.id
json.sender_id @mes.sender_id
json.text @mes.text
json.receiver_id @mes.receiver_id
json.created_at @mes.created_at
json.sender_name User.find(@mes.sender_id).name
json.receiver_name User.find(@mes.receiver_id).name
