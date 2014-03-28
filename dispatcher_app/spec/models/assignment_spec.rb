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
      let!(:driver_1) { create :driver, latitude: 1, longitude: 1 }
      let!(:driver_2) { create :driver, latitude: 1, longitude: 5 }
      let!(:driver_3) { create :driver, latitude: 1, longitude: 10 }
      its(:driver_id) { should be_nil }
      it "should assign driver" do
        assignment.save
        assignment.reload.driver_id.should_not be_nil
      end

      it "should assign nearest driver" do
        assignment.save
        assignment.driver.should eql driver_3 # mock return lat,long = [1,11]
      end
    end
  end


  describe "passenger_app_url" do
    it "should have passenger_app_url" do
      assignment.passenger_app_url.path.should eql '/'
    end
  end
end
