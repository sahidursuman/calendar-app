class Repeating < ActiveRecord::Base
  belongs_to :instructor
  has_many :bookings
  serialize :days_of_the_week

  before_create :arrayify

private 
  def arrayify
    self.days_of_the_week.map! {|value| value.to_i}
  end

  # def strfify_start_and_end 
  #   self.start_time.strftime('%I:%M:%S %p')
  #   self.end_time.strftime('%I:%M:%S %p')
  # end
end