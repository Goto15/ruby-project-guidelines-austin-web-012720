class User < ActiveRecord::Base
    has_many :days
    has_many :items
    has_many :events, through: :days
end