class Availability < ActiveRecord::Base
  belongs_to :instructor
  has_many :bookings
  has_many :users, through: :bookings
end
