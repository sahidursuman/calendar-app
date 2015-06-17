class Repeating < ActiveRecord::Base
  belongs_to :instructor
  has_many :bookings
  serialize :days_of_the_week



  before_create :arrayify

def day_checker
  dow = []
  start_dates = []
  end_dates = []
  if self.days_of_the_week.present?
    self.days_of_the_week.each do |day|
      if day == 0
        dow << 7
      else
        dow << day
      end
    end
  end
  dow.each do |x|
    start_dates << self.start_time.change(day: x)
    end_dates << self.end_time.change(day: x)
  end
end


private 

# This method must exist for the calendar to read for days of the week(dow)
  def arrayify
    if self.days_of_the_week.present? 
      self.days_of_the_week.map! {|value| value.to_i}
    end
  end






end