json.array!(@r) do |resource|
  json.id resource.id
  json.name resource.name
  json.pricePerUnit resource.pricePerUnit
  json.monthlyCost resource.monthlyCost
  json.annualCost resource.annualCost
  json.description resource.description
  json.startValue resource.startValue
  json.startDate resource.startDate

   json.entries resource.ressourceentries.sort {|a,b| b.date <=> a.date} do |entry|
      json.(entry , :id, :value, :date, :usage, :costs, :isFirst)
  end

end
