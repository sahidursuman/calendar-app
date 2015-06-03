class Availability < ActiveRecord::Base
  belongs_to :instructor
  has_many :bookings
  has_many :users, through: :bookings

  validate :consistent

  def timerange
    TimeRange.new(start_time, end_time)
  end

  private
  def consistent
    unless instructor.availability_open?(self)
      errors.add(:instructor, "is unavailable for that booking")
    end

    if start_time > end_time
      errors.add(:start_time, "Cannot be greater than the end time")
    end
  end

end
