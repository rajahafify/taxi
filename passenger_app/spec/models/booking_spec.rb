require 'spec_helper'

describe Booking do
  let(:booking) { build :booking }

  subject { booking }

  it { should respond_to :latitude }
  it { should respond_to :longitude }
  it { should respond_to :user_id }
  it { should be_valid }

  describe "validation" do
    %w(latitude longitude).each do |attr|
      it "presence" do
        @booking = build :booking, attr.to_sym => nil
        @booking.should_not be_valid
      end
    end
  end

  describe "belongs to user" do
    before do
      @user = create :user
      @booking = create :booking, user: @user
    end

    subject { @booking }

    its(:user_id) { should eql @user.id }
  end
end
