require_relative '../config/environment'
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
  user = login.ask("Name: ", required: true)
  user  = User.all.find(user)
  main_menu(user.id)
end

def signup_prompt()
  signup = TTY::Prompt.new()
  user = signup.ask("Name: ", required: true)
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
  main_menu(user.id)
end


def user_menu(user_id)
  user_menu = TTY::Prompt.new()
  ans = user_menu.select("Tools: ", required: true) do |menu|
    menu.choice "ADD", 1 #add_menu(user_id)
    menu.choice "VIEW", 2 #view_menu(user_id)
    menu.choice "DELTE", 3 #delete_menu(user_id)
  end

  case ans
  when 1
    add_menu(user_id)
  when 2
    view_menu(user_id)
  when 3
    delete_menu(user_id)
  end
end

def add_menu(user_id)
  add_menu = TTY::Prompt.new()
  add_menu.select("ADD: ", required: true) do |menu|
    menu.choice "Items", add_items(user_id)
    menu.choice "Events", add_events(user_id)
    menu.choice "Itenerary", add_itenerary(user_id)
    menu.choice "Main Menu", main_menu(user_id)
  end
end

# def edit_menu(user_id)
#   edit_menu = TTY:Prompt.new()
#   edit_menu.select("EDIT: ", required: true) do |menu|
#     menu.choice "Location", edit_items(user_id)
#     menu.choice "Events", edit_events(user_id)
#     menu.choice "Itenerary", edit_itenerary(user_id)
#     menu.choice "Main Menu", main_menu(user_id)
#   end
# end

def view_menu(user_id)
  view_menu = TTY::Prompt.new()
  view_menu.select("VIEW: ", required: true) do |menu|
    menu.choice "Items", view_items(user_id)
    menu.choice "Events", view_events(user_id)
    menu.choice "Day", view_day(user_id)
    menu.choice "Main Menu", main_menu(user_id)
  end
end

def delete_menu(user_id)
  delete_menu = TTY::Prompt.new()
  delete_menu.select("DELETE: ", required: true) do |menu|
    menu.choice "Items", delete_items(user_id)
    menu.choice "Events", delete_events(user_id)
    menu.choice "Day", delete_day(user_id)
    menu.choice "Main Menu", main_menu(user_id)
  end
end

def add_items(user_id)
  add_item = TTY::Prompt.new()
  add_item.select("Item Type: ", required: true) do |menu|
    menu.choice "Daily"
    menu.choice ""
  end
end

startmenu()
