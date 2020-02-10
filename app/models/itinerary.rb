class Itinerary < ActiveRecord::Base
    has_many :events
    has_many :items
    belongs_to :user
end