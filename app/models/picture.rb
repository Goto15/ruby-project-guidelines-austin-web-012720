class Picture < ActiveRecord::Base
    has_many :user_pictures
    has_many :users, through: :user_pictures
end