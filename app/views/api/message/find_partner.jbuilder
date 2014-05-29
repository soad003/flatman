if @partner[:flat_name].length == 0
	json.id @partner[:id]
	json.name User.find(@partner[:id]).name
else
	json.name @partner[:flat_name]
end

