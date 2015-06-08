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
      errors.add(:instructor, "is unavailable at that time.")
    end

    if start_time >= end_time
      errors.add(:start_time, "cannot be greater than the end time")
    elsif start_time < Time.now
      errors.add(:start_time, "cannot be earlier than the current time")
    end
  end
end
