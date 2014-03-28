require 'spec_helper'

describe Api::V1::AssignmentsController do
  let!(:driver) { create :driver }
  describe "create" do
    it "should create assignment" do
      expect do
        post :create, booking_id: 1
      end.to change(Assignment, :count).by 1
    end

    it "should return driver_id" do
      post :create, booking_id: 1
      response.should be_success
      json.should have_key 'status'
      json['status'] = 'success'
      json.should have_key 'driver_id'
      json['driver_id'] = driver.id
    end
  end
end
