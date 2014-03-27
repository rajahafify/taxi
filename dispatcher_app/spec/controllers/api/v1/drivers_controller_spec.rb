require 'spec_helper'

describe Api::V1::DriversController do
  let(:driver) { create :driver }
  describe "details" do
    it "should be success" do
      get :details, id: driver.id
      response.should be_success
    end

    it "should return driver details" do
      get :details, id: driver.id
      json.should have_key 'driver_name'
      json['driver_name'].should eql driver.name
      json.should have_key 'driver_phone_number'
      json['driver_phone_number'].should eql driver.phone_number
    end
  end
end
