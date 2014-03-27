require 'spec_helper'

describe Booking do
  let(:booking) { build :booking }

  subject { booking }

  it { should respond_to :latitude }
  it { should respond_to :longitude }
  it { should respond_to :user_id }
  it { should respond_to :driver_assigned? }
  its(:driver_assigned?) { should be_false }
  it { should respond_to :driver_id }
  its(:driver_id) { should be_nil }
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

  context "callback" do
    describe "after_create" do
      describe "assign_driver" do
        let(:booking) { build :booking }
        it "should assign driver_id" do
          booking.driver_assigned?.should be_false
          booking.driver_id.should be_nil
          booking.save
          booking.driver_assigned?.should be_true
          booking.driver_id.should_not be_nil
          booking.driver_id.should eql 1
        end
      end
    end
  end

  describe "if have driver_assigned?" do
    let(:booking) { create :booking_with_driver }

    subject { booking }

    its(:driver_assigned?) { should be_true }
    its(:driver_id) { should_not be_nil }
  end
end
