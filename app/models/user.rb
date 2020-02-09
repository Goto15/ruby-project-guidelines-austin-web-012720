class User < ActiveRecord::Base
    has_many :pictures, through: :user_pictures
    has_many :settings
end