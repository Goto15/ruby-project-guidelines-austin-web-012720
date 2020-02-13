
def user_settings_menu(user_id)
  display_user_settings(user_id)

  ans = TTY::Prompt.new.select("Update: ") do |menu|
    menu.choice "Name"
    menu.choice "Location"
    menu.choice "Contact"
    menu.choice "↵ Back" , "Back"
  end

  prompt = TTY::Prompt.new()
  user = User.find(user_id)
  case ans
  when "Name"
    check = true
    while check
      name = prompt.ask("Name: ", required: true)
      if (User.where(name: name).length != 0)
        puts "Someone with your name exists already. Please login or try again."
      else
        check = false
      end
    end
    user.name = name
    user.save
    user_settings_menu(user_id)

  when "Location"
    location = "123456"
    while location.length > 5
      location =  prompt.ask("Enter 5 Digit Zip Code: ", required: true) do |zip|
                  zip.validate (/^\d{5}/)
                end
    end
    user.location =location
    user.save
    user_settings_menu(user_id)

  when "Contact"
    contact = prompt.ask("Enter Email: ", required: true)
    user.contact = contact
    user.save
    user_settings_menu(user_id)

  when "Back"
    user_menu(user_id)
  end
end


def display_user_settings(user_id)

  puts `clear`
  user = User.find(user_id)
  output = <<-OUT
Username: #{user.name}
Location: #{user.location}
Contact: #{user.contact}
OUT
width = (33)
height = (5)
  box = TTY::Box.frame(width: width, height: height , title: {top_center: " CURRENT USER SETTINGS "}) do
      output
  end
  print box

end
