class RepeatingAvailability < ActiveRecord::Base
  belongs_to :instructor
  has_many :bookings
  has_many :users, through: :bookings
  serialize :days_of_the_week

end
