class User < ActiveRecord::Base
    has_many :days
    has_many :events, through: :days
    has_many :items, through: :days
end