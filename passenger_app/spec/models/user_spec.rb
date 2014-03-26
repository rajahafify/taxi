require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create :user }

  subject { user }

  it { should respond_to :phone_number }
  it { should respond_to :auth_token }

  describe "before_validation" do
    describe "#generate_auth_token" do
      its(:auth_token) { should_not be_nil }
    end
  end

  describe "validation" do
    it "should validate presence of phone number" do
      @user = FactoryGirl.build :user, phone_number: nil
      @user.should_not be_valid
    end
  end
end
