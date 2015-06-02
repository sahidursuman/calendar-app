class Instructor < ActiveRecord::Base
belongs_to :user
has_many :bookings
has_many :availabilities
has_many :users, through: :bookings

end
