json.array!(@mates) do |entry|
    json.(entry , :id, :username)
end
