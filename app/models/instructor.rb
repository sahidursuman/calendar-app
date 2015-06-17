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
    
    available_repeating_booking = if self.repeatings.any? 
      self.repeatings.each do |repeating|
        repeating.day_checker.any? do |array|
          starting = array.first.change(day: requested_booking.start_time.day, month: requested_booking.start_time.month)
          ending = array.last.change(day: requested_booking.end_time.day, month: requested_booking.end_time.month)
          repeating_range = TimeRange.new(starting, ending)
          repeating_range.in_range?(new_booking)
        end
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

end