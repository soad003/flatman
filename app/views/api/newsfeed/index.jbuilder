json.array!(@newsfeed) do |newsitem|
  json.name newsitem.user.name
  json.text newsitem.text
  json.date newsitem.date
  json.header newsitem.header
  json.category newsitem.category
  json.action newsitem.action
  json.image newsitem.image
end