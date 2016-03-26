json.array!(@mates) do |user|
	json.id user.id
	json.name "[#{user.username}] #{user.name}"
end
