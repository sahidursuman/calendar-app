class Repeating < ActiveRecord::Base
  belongs_to :instructor
  has_many :bookings
  serialize :days_of_the_week

end
