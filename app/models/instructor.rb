class Instructor < ActiveRecord::Base
	belongs_to :teacher, class_name: 'User', foreign_key: :teacher_id
	has_many :bookings
	has_many :availabilities
	has_many :users, through: :bookings
	mount_uploader :avatar, AvatarUploader


  def double_availability?(requested_availability)
    new_availability = requested_availability.timerange    

    no_other_availabilities = self.availabilities.none? do |availability|
      availability.timerange.overlap?(new_availability)
    end

    no_other_availabilities
  end

 
end
