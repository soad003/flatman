json.array!(@f) do |json, finance|
  json.name finance.text
  json.cat finance.billcategory_id
  json.value finance.value
  json.user_id finance.user.id
  json.date finance.date
  json.id finance.id
  json.cat_name finance.billcategory.name
end
