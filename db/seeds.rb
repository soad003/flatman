Bill.create!([
  {value: 42.0, date: "2016-03-19 00:00:00", user_id: 1, billcategory_id: 1, text: "shopping: eggs", flat_id: 1},
  {value: 8.0, date: "2016-03-19 00:00:00", user_id: 1, billcategory_id: 2, text: "toilet paper", flat_id: 1},
  {value: 8.0, date: "2016-03-19 00:00:00", user_id: 2, billcategory_id: 2, text: "toilet paper", flat_id: 1},
  {value: 15.0, date: "2016-03-19 00:00:00", user_id: 3, billcategory_id: 1, text: "shopping: milk, bread", flat_id: 1}
])
Billcategory.create!([
  {flat_id: 1, name: "food"},
  {flat_id: 1, name: "hygienic"}
])
Flat.create!([
  {name: "Superflat 3000", street: nil, city: nil, zip: nil, image_path: nil, latitude: nil, longitude: nil, token: "RxPYdCoRWOJiVLnFvOONUg"}
])
Newsitem.create!([
  {text: "Supermarket", user_id: 1, flat_id: 1, newsitem_id: nil, category: "shoppinglist", action: "add", key: 1},
  {text: "medicine, deodorant, toilet paper", user_id: 1, flat_id: 1, newsitem_id: nil, category: "shoppinglistitem", action: "add", key: 2},
  {text: "Drugstore", user_id: 2, flat_id: 1, newsitem_id: nil, category: "shoppinglist", action: "add", key: 2},
  {text: "shopping: eggs", user_id: 3, flat_id: 1, newsitem_id: nil, category: "bill", action: "add", key: 1},
  {text: "toilet paper", user_id: 4, flat_id: 1, newsitem_id: nil, category: "bill", action: "add", key: 3},
  {text: "shopping: milk, bread", user_id: 3, flat_id: 1, newsitem_id: nil, category: "bill", action: "add", key: 4},
  {text: "Milk, Eggs, Toast, carrots, potatos, beer", user_id: 2, flat_id: 1, newsitem_id: nil, category: "shoppinglistitem", action: "add", key: 1},
  {text: "toilet paper", user_id: 1, flat_id: 1, newsitem_id: nil, category: "bill", action: "add", key: 2},
  {text: "Repair", user_id: 4, flat_id: 1, newsitem_id: nil, category: "todolist", action: "add", key: 1},
  {text: "Bike, Fridge", user_id: 1, flat_id: 1, newsitem_id: nil, category: "todolistitem", action: "add", key: 1},
  {text: "Fine, thanks...", user_id: 1, flat_id: 1, newsitem_id: 11, category: "comment", action: "add", key: nil},
  {text: "Hi mates, how are you?", user_id: 3, flat_id: 1, newsitem_id: nil, category: "message", action: "add", key: nil},
  {text: "oh no", user_id: 1, flat_id: 1, newsitem_id: 9, category: "comment", action: "add", key: nil},
  {text: "Alice Barker", user_id: 1, flat_id: 1, newsitem_id: nil, category: "payment", action: "add", key: 1}
])
Payment.create!([
  {payer_id: 3, value: 25.0, payee_id: 1, date: "2016-03-19 05:36:36", flat_id: 1}
])
Shoppinglist.create!([
  {name: "Drugstore", flat_id: 1, user_id: nil, deleted_at: nil},
  {name: "Supermarket", flat_id: 1, user_id: nil, deleted_at: nil}
])
Shoppinglistitem.create!([
  {name: "toilet paper", checked: false, user_id: 1, shoppinglist_id: 2, deleted_at: nil},
  {name: "deodorant", checked: false, user_id: 1, shoppinglist_id: 2, deleted_at: nil},
  {name: "medicine", checked: false, user_id: 1, shoppinglist_id: 2, deleted_at: nil},
  {name: "beer", checked: false, user_id: 1, shoppinglist_id: 1, deleted_at: nil},
  {name: "potatos", checked: false, user_id: 1, shoppinglist_id: 1, deleted_at: nil},
  {name: "carrots", checked: false, user_id: 1, shoppinglist_id: 1, deleted_at: nil},
  {name: "Toast", checked: false, user_id: 1, shoppinglist_id: 1, deleted_at: nil},
  {name: "Eggs", checked: false, user_id: 1, shoppinglist_id: 1, deleted_at: nil},
  {name: "Milk", checked: false, user_id: 1, shoppinglist_id: 1, deleted_at: nil}
])
Todo.create!([
  {name: "Repair", flat_id: 1, user_id: nil}
])
TodoItem.create!([
  {name: "Bike", checked: false, user_id: 1, todo_id: 1},
  {name: "Fridge", checked: false, user_id: 1, todo_id: 1}
])
User.create!([
  {flat_id: 1, email: "max.huber@test.at", provider: nil, uid: nil, name: "John Doe\n", oauth_token: nil, oauth_expires_at: nil, image_path: "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xaf1/v/t1.0-9/18352_1205663668597_3700689_n.jpg?oh=a81e7347d5970f1a5edebf53fe03f642&oe=574A7DB4&__gda__=1464960330_5d3ef9c7d9d1d9fddd9f466152f4b1b8", device_token: nil, locale: "en", platform: "android", pushflag: true},
  {flat_id: 1, email: "max.huber@test.at", provider: nil, uid: nil, name: "Alice Barker", oauth_token: nil, oauth_expires_at: nil, image_path: "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-xlt1/t31.0-8/12819187_10209290282962637_2478678466968424713_o.jpg", device_token: nil, locale: "en", platform: "android", pushflag: true},
  {flat_id: 1, email: "max.huber@test.at", provider: nil, uid: nil, name: "Bob Fawell", oauth_token: nil, oauth_expires_at: nil, image_path: "https://scontent-vie1-1.xx.fbcdn.net/hphotos-ash2/v/t1.0-0/p206x206/1004643_10200336739529816_1674247020_n.jpg?oh=779ee7c54237983534e2b320556a367f&oe=578F64C5", device_token: nil, locale: "en", platform: "android", pushflag: true},
  {flat_id: 1, email: "cle1000.cb@gmail.com", provider: "google_oauth2", uid: "116226731945755969597", name: "Jack Smith", oauth_token: "ya29.qgLJCQsaUMaaYpYiDArB8sa6JDGC_GeyWnLKnXH8SOv-gGWeIUIl1-ewQW-j44ippY3vjD0", oauth_expires_at: "2016-03-19 06:23:17", image_path: "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg", device_token: nil, locale: "en", platform: "android", pushflag: true}
])
