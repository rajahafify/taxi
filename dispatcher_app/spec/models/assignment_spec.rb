require 'spec_helper'

describe Assignment do
  let(:assignment) { build :assignment }

  subject { assignment }

  it { should respond_to :booking_id }
  it { should respond_to :latitude }
  it { should respond_to :longitude }
  it { should respond_to :driver_id }
  it { should be_valid }

  describe "validation" do
    describe "presence" do
      let(:assignment) { build :assignment, booking_id: nil }
      subject { assignment }
      it { should_not be_valid }
    end
  end
end
