require "tty-box"
#require 'terminfo'
require './models'

def display_items(user_id)
  #user = User.where(id: user_id)
  puts `clear`
  w = (200)#(TermInfo.screen_size[1]).round
  h = (100)#(TermInfo.screen_size[0]-10).round
  items = Item.where(user_id: user_id)
  daily_items = items.select{|item| item.weather.include?("daily")}
  weather_items = items - daily_items
  daily_items = daily_items.collect{|item| item.name}
  weather_items = weather_items.collect{|item| item.name + ": " + item.weather.gsub("daily","")}
  output = "-- Daily Items -- \n" + daily_items.join("\n") + "\n-- Weather Items -- \n" + weather_items.join("\n")
  weather_items.to_s
  box = TTY::Box.frame(width: w, height: h , title: {top_center: ' ITEM MENU ', bottom_left: " Current User: " + user_id.to_s + " "}) do
    output
  end
  print box



end


#------TESTING-------
