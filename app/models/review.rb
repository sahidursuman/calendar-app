class Review < ActiveRecord::Base
  belongs_to :student, class_name: 'User'
  belongs_to :instructor

  validates :comment, presence: true
end
