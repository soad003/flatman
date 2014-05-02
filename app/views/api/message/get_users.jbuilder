json.array!(@users) do |json, user|
  json.id user.id
  json.name user.name
  json.email user.email
  json.uid user.uid
  json.flat_name Flat.find(User.where(name: user.name).first).name
  json.flat_id Flat.find(User.where(name: user.name).first).id
  json.flat_street Flat.find(User.where(name: user.name).first).street
end