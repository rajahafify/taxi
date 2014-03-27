class Booking < ActiveRecord::Base
  require 'open-uri'
  require 'net/http'
  validates :latitude, presence: true
  validates :longitude, presence: true

  DISPATCHER_APP_URL = 'http://localhost:3001/'

  belongs_to :user

  after_create :assign_driver

  def details
    if self.driver_assigned?
      url = self.dispatcher_url + 'driver'
      @details ||= eval open("#{url}/#{self.driver_id}").read # unsafe;
    else
      @details = {}
    end
  end

  def dispatcher_url
    URI.parse DISPATCHER_APP_URL
  end

  private

    def assign_driver
      url = self.dispatcher_url + 'assign'
      req = Net::HTTP::Post.new(url.path)
      req.form_data = { booking_id: self.id }
      con = Net::HTTP.new(url.host, url.port)
      con.start do |http|
        request = http.request(req)
        if request.body and eval(request.body)[:driver_id]
         self.driver_id = eval(request.body)[:driver_id]
         self.driver_assigned = true
         self.save
        end
      end
    end
end
