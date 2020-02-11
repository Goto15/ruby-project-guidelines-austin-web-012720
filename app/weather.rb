require 'json'
require 'net/http'
require 'open-uri'
require_relative './models/item.rb'


units = imperial

location = 78702
location2 = 78750

url = "http://api.openweathermap.org/data/2.5/weather?zip=78702&units=imperial&appid=9990d87a300a8874422373162d3e7b93"

response = Net::HTTP.get_response(URI.parse(url))

puts JSON.parse(response.body)

it = Item.where(id: 1)[0]
puts it.name