class Instructor < ActiveRecord::Base
	belongs_to :teacher, class_name: 'User', foreign_key: :teacher_id
	has_many :bookings
	has_many :availabilities
	has_many :users, through: :bookings
	mount_uploader :avatar, AvatarUploader
	mount_uploader :resume, ResumeUploader


  def availability_open?(requested_availability)
    new_availability = requested_availability.timerange    

    no_other_availabilities = self.availabilities.reload.none? do |availability|
      availability.timerange.overlap?(new_availability)
    end

    no_other_availabilities
  end

  def bookable?(requested_booking)
    new_booking = requested_booking.timerange

    no_double_booking = self.bookings.none? do |booking|
      booking.timerange.overlap?(new_booking)
    end
    
    available_booking = self.availabilities.any? do |availability|
      availability.timerange.in_range?(new_booking)
    end 

    no_double_booking && available_booking
  end

end
