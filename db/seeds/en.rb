User.create!([
  {
    flat_id: 1,
    email: "max.mueller@example.com",
    provider: "facebook",
    uid: '10205824709125627',
    name: "Max Doe",
    oauth_token: "1",
    oauth_expires_at: nil,
    image_path: "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg",
    device_token: nil,
    locale: "en",
    platform: "android",
    pushflag: true
  },
  {
    flat_id: 1,
    email: "julia.maier@example.com",
    provider: "facebook",
    uid: '10205824709125628',
    name: "Julia Kingston",
    oauth_token: "2",
    oauth_expires_at: nil,
    image_path: "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg",
    device_token: nil,
    locale: "en",
    platform: "android",
    pushflag: true
  },
  {
    flat_id: 1,
    email: "peter.franz@example.com",
    provider: "facebook",
    uid: "10205824709125629",
    name: "Peter Hold",
    oauth_token: "3",
    oauth_expires_at: "2016-03-19 06:23:17",
    image_path: "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg",
    device_token: nil,
    locale: "en",
    platform: "android",
    pushflag: true
  }
])

Flat.create!([
  {
    name: "Awesome Flat",
    street: nil,
    city: 'Innsbruck',
    zip: '6020',
    image_path: nil,
    latitude: nil,
    longitude: nil,
    token: "ZwYRef3JO-_a64CcdQpDEw"
  }
])

Bill.create!([
  {
    value: 3.0,
    date: "2016-03-19 10:00:00",
    user_id: 2,
    billcategory_id: 1,
    text: "French Bread",
    user_ids: [ 1, 2, 3 ],
    flat_id: 1
  },
  {
    value: 12.0,
    date: "2016-03-18 10:00:00",
    user_id: 2,
    billcategory_id: 2,
    text: "Deodorant, Shower Gel",
    user_ids: [ 1, 2, 3 ],
    flat_id: 1
  },
  {
    value: 3.99,
    date: "2016-03-17 10:00:00",
    user_id: 3,
    billcategory_id: 2,
    text: "Window Cleaner",
    user_ids: [ 1, 2, 3 ],
    flat_id: 1
  },
  {
    value: 3.99,
    date: "2016-03-18 10:00:00",
    user_id: 3,
    billcategory_id: 3,
    text: "Tape, Drinking Straws, Garbage Bags",
    user_ids: [ 1, 2, 3 ],
    flat_id: 1
  }
])

Billcategory.create!([
  {
    flat_id: 1,
    name: "Food"
  },
  {
    flat_id: 1,
    name: "Hygiene"
  },
  {
    flat_id: 1,
    name: "Utils"
  }
])

Newsitem.create!([
  {
    text: "Hey guys, anyone motivated to party tonight?",
    user_id: 3,
    flat_id: 1,
    newsitem_id: nil,
    category: "message",
    action: "add",
    key: nil,
    created_at: '2016-03-19 16:15:03'
  },
  {
    text: "Chips, Pretzel Sticks, Drinks, Lemonade, Frozen Pizza",
    user_id: 1,
    flat_id: 1,
    newsitem_id: nil,
    category: "shoppinglistitem",
    action: "add",
    key: 2,
    created_at: '2016-03-18 13:20:03'
  },
  {
    text: "Party-Night!",
    user_id: 1,
    flat_id: 1,
    newsitem_id: nil,
    category: "shoppinglist",
    action: "add",
    key: 1,
    created_at: '2016-03-18 13:10:03'
  },
  {
    text: "Label doorbell, label postbox",
    user_id: 3,
    flat_id: 1,
    newsitem_id: nil,
    category: "todolistitem",
    action: "add",
    key: 2,
    created_at: '2016-03-17 11:20:03'
  },
  {
    text: "Todo Flat",
    user_id: 3,
    flat_id: 1,
    newsitem_id: nil,
    category: "todolist",
    action: "add",
    key: 1,
    created_at: '2016-03-17 11:15:03'
  },
  {
    text: "French Bread",
    user_id: 2,
    flat_id: 1,
    newsitem_id: nil,
    category: "shoppinglistitem",
    action: "add",
    key: 2,
    created_at: '2016-03-16 18:20:03'
  },
  {
    text: "Bakery",
    user_id: 2,
    flat_id: 1,
    newsitem_id: nil,
    category: "shoppinglist",
    action: "add",
    key: 2,
    created_at: '2016-03-16 18:00:03'
  }
])

Payment.create!([
  {
    payer_id: 3,
    value: 25.0,
    payee_id: 1,
    date: "2016-03-19 13:36:36",
    flat_id: 1
  },
  {
    payer_id: 2,
    value: 15.0,
    payee_id: 1,
    date: "2016-03-18 11:36:36",
    flat_id: 1
  }
])

Shoppinglist.create!([
  {
    name: "Party-Night",
    flat_id: 1,
    user_id: nil,
    deleted_at: nil
  },
  {
    name: "Bakery",
    flat_id: 1,
    user_id: nil,
    deleted_at: nil
  }
])

Shoppinglistitem.create!([
  {
    name: "Chips",
    checked: false,
    user_id: 1,
    shoppinglist_id: 1,
    deleted_at: nil
  },
  {
    name: "Pretzel Sticks",
    checked: false,
    user_id: 1,
    shoppinglist_id: 1,
    deleted_at: nil
  },
  {
    name: "Drinks",
    checked: false,
    user_id: 1,
    shoppinglist_id: 1,
    deleted_at: nil
  },
  {
    name: "Lemonade",
    checked: false,
    user_id: 1,
    shoppinglist_id: 1,
    deleted_at: nil
  },
  {
    name: "Frozen Pizza",
    checked: false,
    user_id: 1,
    shoppinglist_id: 1,
    deleted_at: nil
  },
  {
    name: "French Bread",
    checked: false,
    user_id: 1,
    shoppinglist_id: 2,
    deleted_at: nil
  }
])

Todo.create!([
  {
    name: "Todo Flat",
    flat_id: 1,
    user_id: nil
  }
])

TodoItem.create!([
  {
    name: "Label doorbell",
    checked: false,
    user_id: 1,
    todo_id: 1
  },
  {
    name: "label postbox",
    checked: false,
    user_id: 1,
    todo_id: 1
  }
])