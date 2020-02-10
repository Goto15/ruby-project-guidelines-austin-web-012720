require_relative '../config/environment'


ben = User.create(name: "Ben", location: 78702, default_items: "phone, wallet, backpack")
jaq = User.create(name: "Jaq", location: 78750, default_items: "phone, wallet, backpack")

coat = Item.create(name: "Raincoat")
sunscreen = Item.create(name: "Sunscreen")

flatiron = Event.create(name: "Flatiron")
bus = Event.create(name: "Bus ride")



puts "HELLO WORLD"
