json.array!(@users) do |json, user|
  json.id user.id
  json.name user.name
  json.email user.email
  json.uid user.uid
  json.flat_name Flat.find(User.find(user.id).flat_id).name
  json.flat_id User.find(user.id).flat_id
  json.flat_street Flat.find(User.find(user.id).flat_id).street
end