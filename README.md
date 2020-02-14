# Command Line Day Planner

This is a day planner built for the commandline. It is built using ActiveRecord on a SQLite backend exposed via commandline. 

## Technologies

[Ruby](https://www.ruby-lang.org/en/), [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html), [SQLite3](https://sqlite.org/index.html), [TTY-Prompt](https://github.com/piotrmurach/tty-prompt)

## Installation

Clone the repo and then navigate to the bin directory via commandline. Once there type 

`ruby run.rb`

This will bring up the Login menu. 

## Notable Features

CLDP pulls weather information from [OpenWeatherMap](https://openweathermap.org/)'s weather forecasting API. Using this information CLDP can build a list of items that a user needs to remember along with a list of events that the user has during the upcoming day. Navigating through the CLI allows users to add events by day, items by weather or for EDC, and allows them to view the current day's item and events. 