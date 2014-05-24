json.array!(@mates) do |entry|
    json.(entry , :id, :name)
end
