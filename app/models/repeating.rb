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
  return dow 
end


private 
  def arrayify
    if self.days_of_the_week.present? 
      self.days_of_the_week.map! {|value| value.to_i}
    end
  end






end