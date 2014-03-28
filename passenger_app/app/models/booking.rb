class Booking < ActiveRecord::Base
  require 'open-uri'
  require 'net/http'
  validates :latitude, presence: true
  validates :longitude, presence: true

  DISPATCHER_APP_URL = 'http://localhost:3001/'

  belongs_to :user

  after_create :create_job_assign_driver

  def details
    uri = dispatcher_url
    uri.path = "/api/v1/drivers/#{driver_id}/details"
    if driver_assigned?
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      @details ||= JSON.parse http.request(request).body
    else
      @details = {}
    end
  end

  def dispatcher_url
    URI.parse DISPATCHER_APP_URL
  end

  def assign_driver
    unless driver_assigned?
      begin
        uri = self.dispatcher_url
        uri.path = '/api/v1/assignments'
        req = Net::HTTP::Post.new(uri.path)
        req.form_data = { booking_id: self.id }
        con = Net::HTTP.new(uri.host, uri.port)
        con.start do |http|
          request = http.request(req)
          if request.body and JSON.parse(request.body)[:driver_id]
           self.driver_id = eval(request.body)[:driver_id]
           self.driver_assigned = true
           self.save
          end
        end
      end
    end
  end

  private

    def create_job_assign_driver
      self.delay.assign_driver
    end
end
