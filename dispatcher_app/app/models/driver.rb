class Driver < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  has_many :assignments
  reverse_geocoded_by :latitude, :longitude

  def self.nearest_driver(latitude, longitude)
    @nearest_driver = nil
    distance = Float::INFINITY
    all.each do |driver|
      new_distance = driver.distance_from(latitude,longitude)
      @nearest_driver = driver if distance > new_distance
      distance = new_distance
    end
    return @nearest_driver
  end

  def distance_from(latitude,longitude)
    calculate_distance(latitude,longitude)
  end

  def send_sms
    deliver_sms("You have a booking for with id #{self.assignments.last.booking_id}")
  end

  protected

    def calculate_distance(latitude, longitude)
      Geocoder::Calculations.distance_between(self, [latitude,longitude])
    end

    def deliver_sms(message)
      p message
    end
end
