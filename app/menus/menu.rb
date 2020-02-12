require_relative '../config/environment'
require_relative '../app/models/user.rb'
require_relative '../app/models/item.rb'
require 'tty-prompt'

def startmenu()
  ans =   TTY::Prompt.new.select("Welcome to Day Planner") do |menu|
            menu.choice "Login" 
            menu.choice "Sign Up"
          end

  case ans
  when "Login"
    login_prompt()
  when "Sign Up"
    signup_prompt()
  end
end

def login_prompt()
  username = TTY::Prompt.new.ask("Name: ", required: true)
  if (User.where(name: username).length != 0)
    user = User.where(name: username)[0]
    user_menu(user.id)
  else 
    puts "Your account does not exist. Did you mispell it?"
    ans =   TTY::Prompt.new.select("") do |menu|
      menu.choice "Sign Up"
      menu.choice "Try Again"
    end

    case ans
      when "Sign Up"
        signup_prompt()
      when "Try Again"
        login_prompt()
    end
  end
end

def signup_prompt()
  signup = TTY::Prompt.new()
  name = signup.ask("Name: ", required: true)
  name_check(name)

  location =  signup.ask("Enter 5 Digit Zip Code: ", required: true) do |zip|
                zip.validate (/^\d{5}/)
              end
  contact = signup.ask("Enter Email: ", required: true)
  signup(name, location, contact)
end

def name_check(name)
  if (User.where(name: name).length != 0)
    puts "Someone with your name exists already. Please login or try again."

    ans =   TTY::Prompt.new.select("") do |menu|
      menu.choice "Login"
      menu.choice "Try Again"
    end

    case ans
      when "Login"
        login_prompt()
      when "Try Again"
        signup_prompt()
    end
  end
end

def signup(name, location, contact)
  user = User.create(name: name, location: location, contact: contact)
  user_menu(user.id)
end

def user_menu(user_id)
  ans = TTY::Prompt.new.select("USER MENU: ") do |menu|
    menu.choice "Items"
    menu.choice "Events"
    menu.choice "Day to Day"
    menu.choice "Logout"
  end

  case ans
  when "Items"
    item_menu(user_id)
  when "Events"
    event_menu(user_id)
  when "Day to Day"
    day_menu(user_id)
  when "Logout"
    startmenu()
  end
end

def item_menu(user_id)
  ans = TTY::Prompt.new.select("ITEM MENU: ", required: true) do |menu|
    menu.choice "Add"
    menu.choice "Delete"
    menu.choice "Clear"
    menu.choice "Back"
  end

  case ans
  when "Add"
    add_item_menu(user_id)
  when "Delete"
    delete_item_menu(user_id)
  when "Clear"
    delete_all_items_menu(user_id)
  when "Back"
    user_menu(user_id)
  end

end

def add_item_menu(user_id)
  name = TTY::Prompt.new.ask("Enter Item Name: ", required: true)
  conditions = TTY::Prompt.new.multi_select("Type", required: true) do |type|
    type.choice "Daily"
    type.choice "Thunderstorm"
    type.choice "Rain"
    type.choice "Snow"
    type.choice "Clear"
    type.choice "Overcast"
    type.choice "Hot"
    type.choice "Cold"
  end
  Item.create(user_id: user_id, name: name, weather: conditions.join(", "))

  item_menu(user_id)
end

def delete_item_menu(user_id)
  items = Item.all.select('name').where(user_id: user_id).map do |item|
            item.name
          end
          
  to_delete = TTY::Prompt.new.multi_select("Your items: ", items)

  to_delete.each do |item|
    Item.delete_all(name: item, user_id: user_id)
  end

  item_menu(user_id)
end

def delete_all_items_menu(user_id)
  ans = TTY::Prompt.new.yes?("Are you sure you want to delete all your items?")
  if ans
    ans = TTY::Prompt.new.yes?("Final chance: Are you sure you want to delete all your items?")
    if ans
      Item.delete_all(user_id: user_id)
    end
  end

  item_menu(user_id)
end

def event_menu(user_id)
  ans = TTY::Prompt.new.select("EVENT MENU: ", required: true) do |menu|
    menu.choice "Add"
    menu.choice "Delete"
    menu.choice "Clear"
    menu.choice "Back"
  end

  case ans
  when "Add"
    add_event_menu(user_id)
  when "Delete"
    delete_event_menu(user_id)
  when "Clear"
    delete_all_events_menu(user_id)
  when "Back"
    user_menu(user_id)
  end

end

def add_event_menu(user_id)
  name = TTY::Prompt.new.ask("Enter the event's name: ", required: true)
  date = TTY::Prompt.new.ask("Enter the event's date: ", required: true)

  Event.create(name: name, date: date)

  event_menu(user_id)
end

def delete_event_menu(user_id)
  events = Event.all.map do |event|
    event.name
  end
  
  to_delete = TTY::Prompt.new.multi_select("Your items: ", events)

  to_delete.each do |event|
    Event.delete_all(name: event)
  end

  event_menu(user_id)
end

def delete_all_events_menu(user_id)
  ans = TTY::Prompt.new.yes?("Are you sure you want to delete all your events?")
  if ans
    ans = TTY::Prompt.new.yes?("Final chance: Are you sure you want to delete all your events?")
    if ans
      Event.delete_all(user_id: user_id)
    end
  end

  event_menu(user_id)
end

def day_menu(user_id)
  ans = TTY::Prompt.new.select("DAY MENU: ", required: true) do |menu|
    menu.choice "Add"
    menu.choice "Delete"
    menu.choice "Back"
    menu.choice "Clear"
  end

  case ans
  when "Add"
    add_day_menu(user_id)
  when "Delete"
    delete_day_menu(user_id)
  when "Send"
    send_day_to_device(user_id)
  when "Back"
    user_menu(user_id)
  when "Clear"
    delete_all_days_menu(user_id)
  end

end

def add_day_menu(user_id)
  date = TTY::Prompt.new.ask("Enter the date: ", required: true)

  if (Day.where(date: date).length != 0)
    puts "There's already a day created for this date."
  else
    Day.create(user_id: user_id, date: date)
  end

  day_menu(user_id)
end

def delete_day_menu(user_id)
  days =  Day.all.map do |day|
            day.date
          end.uniq
  
  to_delete = TTY::Prompt.new.multi_select("Your days: ", days)

  to_delete.each do |day|
    Event.delete_all(date: day)
  end

  day_menu(user_id)
end

def delete_all_days_menu(user_id)
  ans = TTY::Prompt.new.yes?("Are you sure you want to delete all your days?")
  if ans
    ans = TTY::Prompt.new.yes?("Final chance: Are you sure you want to delete all your days?")
    if ans
      Day.delete_all()
    end
  end

  day_menu(user_id)
end

def send_day_to_device(user_id)
  puts "Sending your day to your email or your phone..."
  day_menu(user_id)
end