require 'json'
require 'net/http'
require 'open-uri'
require_relative './models/item.rb'

location = 78702
location2 = 78750

def generate_query_url(zip_code)
    base_url = "http://api.openweathermap.org/data/2.5/weather?"
    location = "zip=" + zip_code.to_s
    api_key = "&units=imperial&appid=9990d87a300a8874422373162d3e7b93"

    base_url + location + api_key
end

def generate_forecast(zip_code)
    url = generate_query_url(zip_code)
    response = Net::HTTP.get_response(URI.parse(url))

    forecast = {
        weather: [],
        temp: 0,
        max: 0,
        min: 0
    }

    JSON.parse(response.body).dig("weather").each do |weather|
        forecast[:weather] << weather["main"]
    end
    forecast[:temp] = JSON.parse(response.body).dig("main", "temp")
    forecast[:max] = JSON.parse(response.body).dig("main", "temp_max")
    forecast[:min] = JSON.parse(response.body).dig("main", "temp_min")

    return forecast
end
