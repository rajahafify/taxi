require 'spec_helper'

describe Api::V1::BookingsController do
# create a booking as a user (the user needs to be authenticated with the correct system generated password)
# retrieve the booking id of the newly created booking.
# retrieve the details of the booking with the driver's name and phone number.

  describe "#create" do
    let(:user) { create :user, phone_number: '0123456788' }
    let(:booking) { build :booking }

    context "without auth_token" do
      it "creates booking" do
        expect {
          post :create, user: { phone_number: user.phone_number, auth_token: nil}, booking: { latitude: booking.latitude, longitude: booking.longitude }
        }.to change(Booking, :count).by 0
      end
    end

    context "with auth_token" do
      it "creates booking" do
        expect {
          post :create, user: { phone_number: user.phone_number, auth_token: user.auth_token}, booking: { latitude: booking.latitude, longitude: booking.longitude }
        }.to change(Booking, :count).by 1
      end
    end

    describe "it returns fail status" do
      it "if latitude is missing" do
        post :create, user: { phone_number: user.phone_number, auth_token: user.auth_token}, booking: { latitude: nil, longitude: booking.longitude }
        response.should be_success
        json.should have_key 'status'
        json['status'].should eql 'fail'
      end


      it "if longitude is missing" do
        post :create, user: { phone_number: user.phone_number, auth_token: user.auth_token}, booking: { latitude: booking.latitude, longitude: nil }
        response.should be_success
        json.should have_key 'status'
        json['status'].should eql 'fail'
      end
    end

    describe "it returns success status" do
      it "if latitude and longitude are present" do
        post :create, user: { phone_number: user.phone_number, auth_token: user.auth_token}, booking: { latitude: booking.latitude, longitude: booking.longitude }
        response.should be_success
        json.should have_key 'status'
        json['status'].should eql 'success'
        json.should have_key 'booking_id'
      end
    end
  end

  describe "#show" do
    let!(:booking) { create :booking }
    it "should be success" do
      get :show, id: booking.id
      response.should be_success
    end

    it "should return location json" do
      get :show, id: booking.id
      json.should have_key 'latitude'
      json['latitude'].should eql booking.latitude
      json.should have_key 'longitude'
      json['longitude'].should eql booking.longitude
    end
  end

  describe "#details" do
    let(:booking) { create :booking_with_driver }

    it "should return driver details" do
      get :details, id: booking
      response.should be_success
      json.should have_key 'driver_name'
      json.should have_key 'driver_phone_number'
    end
  end
end
