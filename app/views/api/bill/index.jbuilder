json.totalLength @bills.totalLength
json.subset      @bills.subset do |finance|
  json.name finance.text
  json.cat finance.billcategory_id
  json.value finance.value
  json.user_id finance.user.id
  json.user_name finance.user.name
  json.date finance.date
  json.id finance.id
  json.cat_name finance.billcategory.name
  json.isPaidBy finance.users do |user|
    json.(user, :id, :name)
  end
end
