require 'spec_helper'

describe 'External request' do
  it 'queries example.com' do

    body = open('http://www.example.com').read
    body.should be_an_instance_of(String)
  end
end
