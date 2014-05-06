json.array!(@f) do |json, finance|
  json.name finance.text
  json.cat finance.billcategory_id
  json.value finance.value
  json.user_id finance.user
  json.date finance.date
  json.id finance.id
  json.cat_name Billcategory.find(finance.billcategory_id).name
  json.list @name
end