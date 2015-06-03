class Booking < ActiveRecord::Base
belongs_to :instructor
belongs_to :student, class_name: 'User'
has_one :availability

  def timerange
    TimeRange.new(start_time, end_time)
  end

  def is_available?
    requested_booking = self.timerange
    
    other_instructor_bookings = self.instructor.bookings.all
    sorted_instructor_bookings = other_instructor_bookings.map! do |booking|
      range = []
      range << booking.timerange
      range.sort
      end 
    
  end




end
