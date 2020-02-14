User.create(name: "Ben", location: 78702, contact: "9798140433")
User.create(name: "Jaq", location: 78774, contact: "9798143333")

Event.create(day_id: 1, name: "FlatIron", date: "0212")
Event.create(day_id: 2, name: "bus", date: "0301")

Day.create(user_id: 1, date: "0212")
Day.create(user_id: 2, date: "0301")

Item.create(day_id: 1, user_id: 1, name: "rain coat", weather: "Rain")
Item.create(day_id: 1, user_id: 2, name: "snow shoes", weather: "Snow")
