require_relative '../../config/environment'
require_relative '../weather.rb'
require 'tty-prompt'

# ------ Specific Menus ------ #
require_relative './day_menu.rb'
require_relative './event_menu.rb'
require_relative './item_menu.rb'

def startmenu()
  ans = TTY::Prompt.new.select("Welcome to Day Planner") do |menu|
          menu.choice "Login" 
          menu.choice "Sign Up"
          menu.choice "Exit"
        end

  case ans
  when "Login"
    login_prompt()
  when "Sign Up"
    signup_prompt()
  when "Exit"
    true
  end
end

def login_prompt()
  username = TTY::Prompt.new.ask("Name: ", required: true)

  # Checks if the user exists already
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
  prompt = TTY::Prompt.new()
  name = prompt.ask("Name: ", required: true)
  name_check(name)

  # Only validates for 5 digit long zip codes
  location = "123456"
  while location.length > 5
    location =  prompt.ask("Enter 5 Digit Zip Code: ", required: true) do |zip|
                zip.validate (/^\d{5}/)
              end
  end

  contact = prompt.ask("Enter Email: ", required: true)
    
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