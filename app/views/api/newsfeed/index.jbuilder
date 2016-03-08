json.newsfeed_length  @feed.length
json.data (@feed.data) do |newsitem|
  json.id newsitem.id
  json.user_id newsitem.user.id
  json.name newsitem.user.name
  json.text newsitem.text
  json.date newsitem.date
  json.header newsitem.header
  json.link newsitem.link
  json.category newsitem.category
  json.action newsitem.action
  json.type newsitem.imagetype
  json.comments newsitem.newsitems do |comment|
        json.name comment.user.name
        json.link comment.user.image_path
        json.text comment.text
        json.date comment.date
  end
end