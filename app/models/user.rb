class User < ActiveRecord::Base
    has_many :itineraries
    has_many :events
    has_many :events, through: :itinerary
    has_many :items
    has_many :items, through: :itinerary
end