class Repeating < ActiveRecord::Base
  belongs_to :instructor
  has_many :bookings
  serialize :days_of_the_week



  before_create :arrayify

def day_checker
  
  dow = []
  if self.days_of_the_week.present?
    self.days_of_the_week.each do |day|
      if day == 0
        dow << 7
      else
        dow << day
      end
    end
  end

  start_dates = []
  end_dates = []
  
  dow.each do |x|
    start_dates << self.start_time.change(day: x)
    end_dates << self.end_time.change(day: x)
  end
# This creates an array of arrays that each holds a start and end time
[start_dates, end_dates].transpose
end


private 

# This method must exist for the calendar to read for days of the week(dow)
  def arrayify
    if self.days_of_the_week.present? 
      self.days_of_the_week.map! {|value| value.to_i}
    end
  end






end