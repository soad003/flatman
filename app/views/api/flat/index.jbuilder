json.name           @flat.name
json.id             @flat.id
json.street         @flat.street
json.city           @flat.city
json.zip            @flat.zip
json.token          @flat.token
json.users @flat.users do |user|
	json.id user.id
	json.name "[#{user.username}] #{user.name}"
end
json.invites @flat.invites do |inv|
    json.(inv , :id, :email)
end
