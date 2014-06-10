json.array!(@users) do |user|
  json.id user.id
  json.name user.name
  json.email user.email
  json.uid user.uid
  json.flat_name user.flat.name
  json.flat_id user.flat_id
end