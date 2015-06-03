class Instructor < ActiveRecord::Base
	belongs_to :teacher, class_name: 'User', foreign_key: :teacher_id
	has_many :bookings
	has_many :availabilities
	has_many :users, through: :bookings
	mount_uploader :avatar, AvatarUploader


def availability_is_createable(requested_availability)

end

end
