json.array!(@r) do |json, resource|
  json.id resource.id
  json.name resource.name
  json.pricePerUnit resource.pricePerUnit
  json.monthlyCost resource.monthlyCost
  json.annualCost resource.annualCost
  json.description resource.description
  json.startValue resource.startValue
   json.startDate resource.startDate
  json.entryLength resource.entryLength
end