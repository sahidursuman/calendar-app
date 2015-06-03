class Booking < ActiveRecord::Base
belongs_to :instructor
belongs_to :student, class_name: 'User'
has_one :availability

validate :consistent

  def timerange
    TimeRange.new(start_time, end_time)
  end

  private
  
  def consistent
    unless instructor.bookable?(self)
      errors.add(:instructor, "is unavailable for that booking")
    end

    if start_time > end_time
      errors.add(:start_time, "Cannot be greater than the end time")
    end
  end

end
