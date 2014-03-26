require 'spec_helper'

describe User do
  let(:user) { build :user }

  subject { user }

  it { should respond_to :phone_number }
  it { should respond_to :auth_token }
  it { should respond_to :bookings }
  it { should be_valid }

  describe "before_validation" do
    describe "#generate_auth_token" do
      before do
        user.valid?
      end
      its(:auth_token) { should_not be_nil }
    end
  end

  describe "validation" do
    it "presence" do
      @user = build :user, phone_number: nil
      @user.should_not be_valid
    end

    it "uniqueness" do
      @user = user.dup
      @user.save
      user.should_not be_valid
    end
  end
end
