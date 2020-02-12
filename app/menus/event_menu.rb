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