class Repeating < ActiveRecord::Base
  belongs_to :instructor
  has_many :bookings
  serialize :days_of_the_week

  before_create :arrayify

private 
  def arrayify
    if self.days_of_the_week.present? 
      self.days_of_the_week.map! {|value| value.to_i}
    end
  end

def day_checker
  dow = []
  if self.days_of_the_week.present?
    self.days_of_the_week.each do |day|
      case day
        when "0"
        weekday = "Sunday"
        when "1"
        weekday = "Monday"
        when "2"
        weekday = "Tuesday"
        when "3"
        weekday = "Wednesday"
        when "4"
        weekday = "Thursday"
        when "5"
        weekday = "Friday"
        when "6"
        weekday = "Saturday"
      end
      dow << weekday
    end
    
  end



end



end