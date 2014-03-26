class Booking < ActiveRecord::Base
  validates :latitude, presence: true
  validates :longitude, presence: true

  belongs_to :user
end
