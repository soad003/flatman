json.array!(@newsfeed) do |newsitem|
  json.name newsitem.user.name
  json.text newsitem.text
  json.header newsitem.header
  json.date newsitem.created_at
  json.category newsitem.newsitemcategory.name
  json.image newsitem.user.image_path
end