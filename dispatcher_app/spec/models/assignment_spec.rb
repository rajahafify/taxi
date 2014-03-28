require 'spec_helper'

describe Assignment do
  let(:assignment) { build :assignment }

  subject { assignment }

  it { should respond_to :booking_id }
  it { should respond_to :driver_id }
  it { should respond_to :driver }
  it { should be_valid }

  describe "validation" do
    describe "presence" do
      let(:assignment) { build :assignment, booking_id: nil }
      subject { assignment }
      it { should_not be_valid }
    end

    describe "uniqueness" do
      let(:assignment) { create :assignment }
      it "should not be valid" do
        @assignment = assignment.dup
        @assignment.should_not be_valid
      end
    end
  end

  describe "callbacks" do
    describe "before_create" do
      its(:driver_id) { should be_nil }
      it "should assign driver" do
        assignment.save
        assignment.driver_id.should_not be_nil
      end
    end
  end
end
