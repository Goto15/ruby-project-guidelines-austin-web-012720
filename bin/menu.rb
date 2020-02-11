require_relative '../config/environment'

require_relative '../app/models/user.rb'

require 'tty-prompt'

def startmenu()
  start = TTY::Prompt.new
  ans = start.select("Welcome to Day Planner", requied: true) do |menu|
      menu.choice "Login", 1 #login_prompt()
      menu.choice "Sign Up", 2 #signup_prompt()
  end

  case ans
  when 1
    login_prompt()
  when 2
    signup_prompt()
  end
end

def login_prompt()
  login = TTY::Prompt.new()
  username = login.ask("Name: ", required: true)
  user = User.where(name: username)[0]
  user_menu(user.id)
end

def signup_prompt()
  signup = TTY::Prompt.new()
  name = signup.ask("Name: ", required: true)
  location = signup.ask("Enter Zip Code: ", required: true)
  contact = signup.ask("Enter Email: ", required: true)
  signup(name, location, contact) # if !User.all.find(user)
end

def signup(name, location, contact)
  user = User.new()
  user.name = name
  user.location = location
  user.contact = contact
  user.save
  user_menu(user.id)
end


def user_menu(user_id)
  user_menu = TTY::Prompt.new()
  ans = user_menu.select("USER MENU: ", required: true) do |menu|
    menu.choice "Items", 1
    menu.choice "Events", 2
    menu.choice "Day to Day", 3
    menu.choice "Logout", 4
  end

  case ans
  when 1
    item_menu(user_id)
  when 2
    event_menu(user_id)
  when 3
    day_menu(user_id)
  when 4
    startmenu()
  end
end

def item_menu(user_id)
  i_menu = TTY::Prompt.new()
  ans = user_menu.select("ITEM MENU: ", required: true) do |menu|
    menu.choice "Add", 1
    menu.choice "Delete", 2
    menu.choice "Clear", 3
    menu.choice "Back", 4
  end

  case ans
  when 1
    item = i_menu.ask("Enter Item Name: ", required: true)
    type_menu = TTY::Prompt.new
    array = type_menu.multiselect("Type", required: true) do |type|
      menu.choice "Daily",
      menu.choice "Thunderstorm" ,
      menu.choice "Rain",
      menu.choice "Snow",
      menu.choice "Clear",
      menu.choice "Overcast",
      menu.choice "Hot",
      menu.choice "Cold",
    end
    i = Item.new(name: item, weather: array.join(", "))
    i.save

  when 2
    item = prompt.ask("Enter Item Name: ", required: true)
  when 3
    bool = prompt.yes?("Are you sure you want to clear [Items]?", required: true)
  when 4
    user_menu(user_id)
  end

end

def event_menu(user_id)
  e_menu = TTY::Prompt.new()
  ans = user_menu.select("EVENT MENU: ", required: true) do |menu|
    menu.choice "Add", 1
    menu.choice "Delete", 2
    menu.choice "Clear", 3
    menu.choice "Back", 4
  end

  case ans
  when 1
    item = prompt.ask("Enter Event Name: ", required: true)
  when 2
    item = prompt.ask("Enter Event Name: ", required: true)
  when 3
    bool = prompt.yes?("Are you sure you want to clear [Events]?", required: true)
  when 4
    user_menu(user_id)
  end

end

def day_menu(user_id)
  d_menu = TTY::Prompt.new()
  ans = user_menu.select("DAY MENU: ", required: true) do |menu|
    menu.choice "Add", 1
    menu.choice "Delete", 2
    menu.choice "Clear", 3
    menu.choice "Back", 4
  end

  case ans
  when 1
    item = prompt.ask("Enter Date: (mm/dd):", required: true)
  when 2
    item = prompt.ask("Enter Date: (mm/dd):", required: true)
  when 3
    bool = prompt.yes?("Are you sure you want to clear [Days]?", required: true)
  when 4
    user_menu(user_id)
  end

end
