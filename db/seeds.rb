User.create(name: "Ben", location: 78702, contact: "9798140433", default_items: "phone, wallet, computer")
User.create(name: "Jaq", location: 78750, contact: "9798143333", default_items: "phone, wallet, backpack")

Event.create(day_id: 1, name: "FlatIron", date: "today")
Event.create(day_id: 2, name: "bus", date: "tomorrow")

Day.create(user_id: 1, date: "today")
Day.create(user_id: 2, date: "tomorrow")

Item.create(day_id: 1, user_id: 1, name: "rain coat", weather: "Rain")
Item.create(day_id: 1, user_id: 2, name: "snow shoes", weather: "Snow")
