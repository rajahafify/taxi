require 'spec_helper'

describe Api::V1::UsersController do
# create a user record with my phone number
# retrieve my system generated password based on my phone number.

  describe "#create" do
    it "creates user" do
      expect {
        post :create, user: { phone_number: '0123456789'}
      }.to change(User, :count).by 1
    end

    it "respond with user auth_token" do
      post :create, user: { phone_number: '0123456789'}
      response.should be_success
      json.should have_key 'status'
      json['status'].should eql 'success'
      json.should have_key 'auth_token'
    end

    it "will not create duplicate user" do
      user = create :user
      user.save
      post :create, user: { phone_number: user.phone_number}
      response.should be_success
      json.should have_key 'status'
      json['status'].should eql 'fail'
      json.should_not have_key 'auth_token'
    end
  end
end
