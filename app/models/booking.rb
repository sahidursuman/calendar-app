class Booking < ActiveRecord::Base
has_one :teacher, class_name: 'Instructor'
belongs_to :student, class_name: 'User'
has_one :availability

  def timerange
    TimeRange.new(start_time, end_time)
  end






end
