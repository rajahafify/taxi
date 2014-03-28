class Assignment < ActiveRecord::Base
  validates :booking_id, presence: true, uniqueness: true
  belongs_to :driver
  PASSENGER_APP_URL = 'http://localhost:3000/'
  before_save :assign_driver

  def passenger_app_url
    url = URI.parse PASSENGER_APP_URL
  end

  private

    def assign_driver
      sleep 5
      booking = JSON.parse open("#{self.passenger_app_url}api/v1/bookings/#{self.booking_id}").read
      booking_details = {}
      latitude,longitude = 1,11
      self.driver = Driver.nearest_driver(latitude,longitude)
    end
end
