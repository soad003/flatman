json.array!(@dashboardList) do |resource|
  json.name resource.name
  json.unit resource.unit
  json.cost resource.cost
  json.usage resource.usage
end