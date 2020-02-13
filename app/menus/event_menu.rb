def event_menu(user_id)
  display_events(user_id)

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

  if events.empty?
    TTY::Prompt.new.keypress("You have no events to delete! Press any key to go back.")
  else
    to_delete = TTY::Prompt.new.multi_select("Your events: ", events)

    to_delete.each do |event|
      Event.delete_all(name: event)
    end
  end

  event_menu(user_id)
end

def delete_all_events_menu(user_id)
  ans = TTY::Prompt.new.yes?("Are you sure you want to delete all your events?")
  if ans
    ans = TTY::Prompt.new.yes?("Final chance: Are you sure you want to delete all your events?")
    if ans
      Event.delete_all()
    end
  end

  event_menu(user_id)
end

def display_events(user_id)
  # Display params
  puts `clear`
  width = (33)
  height = (20)

  events = Event.all.map {|event| event.name.to_s + " " + event.date.to_s }
    
  box = TTY::Box.frame(width: width, height: height , title: {top_center: " All Events ", bottom_left: " Current User: " + user_id.to_s + " "}) do
      events.join("\n")
  end
  print box
end