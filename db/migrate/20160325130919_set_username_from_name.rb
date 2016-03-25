class SetUsernameFromName < ActiveRecord::Migration
  User.all.each do |row| row.update_attributes(username: "#{row.name.split(' ')[0]}") end
 end
