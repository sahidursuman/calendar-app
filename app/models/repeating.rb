class Repeating < ActiveRecord::Base
  belongs_to :instructor
  has_many :bookings
  serialize :days_of_the_week

  before_create :arrayify

private 
  def arrayify
    self.days_of_the_week.map! {|value| value.to_i}
  end

end