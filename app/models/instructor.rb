class Instructor < ActiveRecord::Base
	belongs_to :teacher, class_name: 'User', foreign_key: :teacher_id
	has_many :bookings
	has_many :availabilities
  has_many :repeatings
	has_many :users, through: :bookings
	mount_uploader :avatar, AvatarUploader
	mount_uploader :resume, ResumeUploader
	mount_uploader :credential, CredentialUploader
	mount_uploader :credential_extra, CredentialExtraUploader
	validates :country_of_origin, presence: true

  def timerange
    TimeRange.new(start_time, end_time)
  end

  def availability_open?(requested_availability)
    new_availability = requested_availability.timerange    

    no_other_availabilities = self.availabilities.reload.none? do |availability|
      availability.timerange.overlap?(new_availability)
    end

    no_other_availabilities
  end

	def country_name
		if country_of_origin.length <= 3
			ISO3166::Country[country_of_origin]
		else
			country_of_origin
		end
    # country.translations[I18n.locale.to_s] || country.name
  end

  def bookable?(requested_booking)
    new_booking = requested_booking.timerange
    
    available_repeating_booking = self.repeatings.any? do |repeating|
      repeating.days_of_the_week.each do |day|
        if day == requested_booking.wday
          
        end

        starting = array.first.change(day: requested_booking.start_time.day, month: requested_booking.start_time.month)
        ending = array.last.change(day: requested_booking.end_time.day, month: requested_booking.end_time.month)
        repeating_range = TimeRange.new(starting, ending)
        repeating_range.in_range?(new_booking)
        binding.pry
      end
    end 

    no_double_booking = self.bookings.reload.none? do |booking|
      booking.timerange.overlap?(new_booking)
    end
    
    available_booking = self.availabilities.any? do |availability|
      availability.timerange.in_range?(new_booking)
    end
    no_double_booking && (available_booking || available_repeating_booking)
  end

# Gutting code here, combining method in repeating with repeating_availability code in Bookable method
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

def gut_code
array = []

  self.repeatings.each do |repeating|
    repeating.days_of_the_week.each do |day|
    Datetime.new  
    end
  end
end

available_repeating_booking = self.repeatings.any? do |repeating|
      repeating.day_checker.any? do |array|
        starting = array.first.change(day: requested_booking.start_time.day, month: requested_booking.start_time.month)
        ending = array.last.change(day: requested_booking.end_time.day, month: requested_booking.end_time.month)
        repeating_range = TimeRange.new(starting, ending)
        repeating_range.in_range?(new_booking)
        binding.pry
      end
    end 




















end