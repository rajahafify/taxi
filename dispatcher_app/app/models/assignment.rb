class Assignment < ActiveRecord::Base
  validates :booking_id, presence: true, uniqueness: true
  belongs_to :driver
  PASSENGER_APP_URL = 'http://localhost:3000/'
  before_save :assign_driver
  after_create :send_sms

  def passenger_app_url
    url = URI.parse PASSENGER_APP_URL
  end

  private

    def assign_driver
      begin
        uri = passenger_app_url
        uri.path = "/api/v1/bookings/#{self.booking_id}"
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        booking ||= JSON.parse http.request(request).body
        latitude,longitude = booking['latitude'].to_i, booking['longitude'].to_i
        self.driver = Driver.nearest_driver(latitude,longitude)
      end
    end

    def send_sms
      self.driver.delay.send_sms
    end
end
