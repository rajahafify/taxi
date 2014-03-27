require 'spec_helper'

describe Driver do
  let(:driver) { build :driver }

  subject { driver }

  it { should respond_to :name }
  it { should respond_to :phone_number }
  it { should respond_to :latitude }
  it { should respond_to :longitude }
  it { should be_valid }

  describe "validations" do
    %w(name phone_number latitude longitude).each do |attr|
      let(:driver) { build :driver, attr.to_sym => nil }
      it { should_not be_valid}
    end
  end
end
