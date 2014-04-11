json.array!(@re) do |json, resourceentry|
  json.id resourceentry.id
  json.value resourceentry.value
  json.date resourceentry.date
  json.costs resourceentry.costs
  json.usage resourceentry.usage
  json.isFirst resourceentry.isFirst
end