json.general @overview.general do |entry|
  json.name entry.name
  json.usage entry.usage
  json.costs entry.costs
end
json.years @overview.years do |entry|
  json.name entry.name
  json.usage entry.usage
  json.costs entry.costs
end