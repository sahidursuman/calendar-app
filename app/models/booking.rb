class Booking < ActiveRecord::Base
has_one :instructor
belongs_to :student, class_name: 'User'
has_one :availability

  def timerange
    TimeRange.new(start_time, end_time)
  end

  def is_available?
  end




end
