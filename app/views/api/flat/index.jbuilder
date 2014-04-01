json.name           @flat.name
json.id             @flat.id
json.street         @flat.street
json.city           @flat.city
json.zip            @flat.zip
json.id             @flat.id
json.users @flat.users do |user|
    json.(user , :id, :name)
end
