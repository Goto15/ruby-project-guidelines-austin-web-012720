class Picture < ActiveRecord::Base
    has_many :users, through: :user_pictures
end