require 'tty-box'

def item_menu(user_id)
  display_items(user_id)

  ans = TTY::Prompt.new.select("ITEM MENU: ", required: true) do |menu|
    menu.choice "Add"
    menu.choice "Delete"
    menu.choice "Clear"
    menu.choice "⮐ Back"
  end

  case ans
  when "Add"
    add_item_menu(user_id)
  when "Delete"
    delete_item_menu(user_id)
  when "Clear"
    delete_all_items_menu(user_id)
  when "⮐ Back"
    user_menu(user_id)
  end

end

def add_item_menu(user_id)
  name = TTY::Prompt.new.ask("Enter Item Name: ", required: true)
  conditions = TTY::Prompt.new.select("Type", required: true) do |type|
    type.choice "Daily"
    type.choice "Thunderstorm"
    type.choice "Rain"
    type.choice "Snow"
    type.choice "Clear"
    type.choice "Clouds"
    type.choice "Hot"
    type.choice "Cold"
  end
  Item.create(user_id: user_id, name: name, weather: conditions)

  item_menu(user_id)
end

def delete_item_menu(user_id)
  items = Item.all.select('name').where(user_id: user_id).map do |item|
            item.name
          end

    if items.empty?
      TTY::Prompt.new.keypress("You have no items to delete! Press any key to go back.")
    else
      to_delete = TTY::Prompt.new.multi_select("Your items: ", items)

      to_delete.each do |item|
        Item.delete_all(name: item, user_id: user_id)
      end
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

def display_items(user_id)
  # Display params
  puts `clear`
  w = (33)
  h = (15)

  items = Item.where(user_id: user_id)
  daily_items = items.select {|item| item.weather == "Daily"}
  weather_items = items - daily_items
  daily_items = daily_items.collect{|item| item.name}
  weather_items = weather_items.collect{|item| item.name + ": " + item.weather}

  output = "--------- Daily Items ---------\n" + daily_items.join("\n") + "\n-------- Weather Items --------\n" + weather_items.join("\n")
  box = TTY::Box.frame(width: w, height: h , title: {top_center: ' ITEM MENU ', bottom_left: " Current User: " + user_id.to_s + " "}) do
    output
  end
  print box

end
