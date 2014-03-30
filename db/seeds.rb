Bill.create!([
  {value: 555.0, date: nil, user_id: 1, billcategory_id: 1}
])
Billcategory.create!([
  {flat_id: 1, name: "first"}
])
Flat.create!([
  {name: "MC", street: "Seilergasse 14", city: "Innsbruck", zip: "6020", image_path: nil},
  {name: "MSM", street: "Holzhammerstraße 13", city: "Innsbruck", zip: "6020", image_path: nil}
])
Message.create!([
  {sender_id: 1, receiver_id: 2, text: "hallo", header: "header", read: nil}
])
Payment.create!([
  {payer_id: 1, value: 999.0, payee_id: 2, date: nil}
])
Ressource.create!([
  {flat_id: 1, name: "strom", unit: nil, pricePerUnit: nil, monthlyCost: nil, annualCost: nil, description: nil, startValue: nil}
])
Ressourceentry.create!([
  {ressource_id: 1, date: nil, value: 1000.0}
])
Shareditem.create!([
  {name: "bohrer", tags: nil, available: nil, hidden: nil, description: nil, sharingNote: nil, image_path: nil, flat_id: 1}
])
Shoppinglist.create!([
  {name: "merkur", flat_id: 2},
  {name: "hofa", flat_id: 1}
])
Shoppinglistitem.create!([
  {name: "milch", checked: nil, user_id: 1, shoppinglist_id: 2},
  {name: "käse", checked: nil, user_id: 3, shoppinglist_id: 1}
])
User.create!([
  {flat_id: 1, email: nil, provider: nil, uid: nil, name: "Magdalena", oauth_token: nil, oauth_expires_at: nil, image_path: nil},
  {flat_id: 1, email: nil, provider: nil, uid: nil, name: "Cle", oauth_token: nil, oauth_expires_at: nil, image_path: nil},
  {flat_id: 2, email: nil, provider: nil, uid: nil, name: "michi", oauth_token: nil, oauth_expires_at: nil, image_path: nil},
  {flat_id: 2, email: nil, provider: nil, uid: nil, name: "sahin", oauth_token: nil, oauth_expires_at: nil, image_path: nil}
])