json.id @bill.id
json.text @bill.text
json.cat_name @bill.billcategory.name
json.value @bill.value
json.user_id @bill.user.id
json.date @bill.date
json.is_editable @bill.is_editable?
json.user_ids @bill.users.map {|u| u.id }


