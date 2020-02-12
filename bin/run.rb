require_relative '../config/environment.rb'
require_relative '../app/menu.rb'
require_relative '../app/weather.rb'

# ----- Models ----- #
require_relative '../app/models/event.rb'
require_relative '../app/models/item.rb'
require_relative '../app/models/user.rb'
require_relative '../app/models/day.rb'

require 'pry'

startmenu()

binding.pry
puts "HELLO WORLD"
