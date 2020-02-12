def today_formatted()
    month = Time.new.month.to_s
    day = Time.new.day.to_s
  
    if (month.length < 2)
      month.prepend('0')
    end
    if (day.length < 2)
      day.prepend('0')
    end
  
    month + day
end
  
def day_menu(user_id)
    display_day(user_id)
  
    ans = TTY::Prompt.new.select("DAY MENU: ", required: true) do |menu|
      menu.choice "Add"
      menu.choice "Delete"
      menu.choice "Back"
      menu.choice "Send"
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
    when "Send"
      send_day_to_device(user_id)
    when "Clear"
      delete_all_days_menu(user_id)
    end
  
end
  
def add_day_menu(user_id)
    date =  TTY::Prompt.new.ask("Enter the date: (MMDD)", required: true) do |day|
              day.validate (/^\d{4}/)
            end
  
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

def get_daily_event_names(date)
  Event.where(date: date).map do |event|
    event.name
  end
end

def get_daily_item_names(user_id, weather)
    items = []
    
    Item.where(user_id: user_id, weather: "Daily").each do |item|
        items << item.name
    end

    Item.where(user_id: user_id, weather: weather).each do |item|
        items << item.name
    end

    items
end
  
def send_day_to_device(user_id)
    puts "Sending your day to your email or your phone..."
    day_menu(user_id)
end

def display_day(user_id)
  # Display params
    puts `clear`
    width = (33)#(TermInfo.screen_size[1]).round
    height = (20)#(TermInfo.screen_size[0]-10).round

  # Day params
    date = today_formatted()
    events = get_daily_event_names(date)
    forecast = generate_forecast(User.find(user_id).location)
    weather = forecast[:weather][0]
    items = get_daily_item_names(user_id, weather)

    output = <<-OUT
-------- Today's Events -------
#{events.join("\n")}
------- Items for Today -------
#{items.join("\n")}
------ Weather for Today ------
#{weather}
OUT
      
    box = TTY::Box.frame(width: width, height: height , title: {top_center: " Today's Itinerary ", bottom_left: " Current User: " + user_id.to_s + " "}) do
        output
    end
    print box
end