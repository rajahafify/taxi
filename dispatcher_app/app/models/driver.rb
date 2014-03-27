class Driver < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
