require 'spec_helper'

describe Driver do
  let(:driver) { build :driver }

  subject { driver }

  it { should respond_to :name }
  it { should respond_to :phone_number }
  it { should respond_to :latitude }
  it { should respond_to :longitude }
  it { should respond_to :assignments }
  it { should be_valid }

  describe "validations" do
    %w(name phone_number latitude longitude).each do |attr|
      let(:driver) { build :driver, attr.to_sym => nil }
      it { should_not be_valid}
    end
  end

  describe "#distance_from" do
    let!(:driver_1) { create :driver, latitude: 1, longitude: 1 }
    it "distance_from" do
      driver_1.distance_from(1,1).should eql 0.0
      driver_1.distance_from(1,2).should eql 69.08280059848101
      driver_1.distance_from(1,3).should eql 138.16559959430188
    end
  end


  describe "self.nearest_driver" do
    let!(:driver_1) { create :driver, latitude: 1, longitude: 1 }
    let!(:driver_2) { create :driver, latitude: 1, longitude: 5 }
    let!(:driver_3) { create :driver, latitude: 1, longitude: 10 }

    it "should return driver 1" do
      Driver.nearest_driver(1,1).should eql driver_1
      Driver.nearest_driver(1,2).should eql driver_1
      Driver.nearest_driver(1,3).should eql driver_2
      Driver.nearest_driver(1,4).should eql driver_2
      Driver.nearest_driver(1,5).should eql driver_2
      Driver.nearest_driver(1,6).should eql driver_2
      Driver.nearest_driver(1,7).should eql driver_2
      Driver.nearest_driver(1,8).should eql driver_3
      Driver.nearest_driver(1,9).should eql driver_3
      Driver.nearest_driver(1,10).should eql driver_3
      (11..100).each { |n| Driver.nearest_driver(1,n).should eql driver_3 }
    end
  end
end
