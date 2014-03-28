ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl_rails'
require 'webmock/rspec'
require 'open-uri'

WebMock.disable_net_connect!(allow_localhost: false)

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
include ActionDispatch::TestProcess

RSpec.configure do |config|
  Delayed::Worker.delay_jobs = false
  config.include FactoryGirl::Syntax::Methods

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.include Requests::JsonHelpers, :type => :controller
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.before(:each) do
    stub_request(:get, /www.example.com/).
      with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, body: "stubbed response", headers: {})
    stub_request(:get, "http://localhost:3001/driver/1").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{driver_name: 'ALI', driver_phone_number: '0123456777'}", :headers => {})
    stub_request(:post, "http://localhost:3001/assign").
      with(:body => {"booking_id"=>"1"},
          :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{driver_id: 1}", :headers => {})
    stub_request(:get, "http://localhost:3001/api/v1/drivers/1/details").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => '{"driver_name":"Llewellyn Skiles","driver_phone_number":"1-130-025-5473 x19570"}', :headers => {})
    # stub_request(:post, "http://localhost:3001/api/v1/assignments").
    #   with(:body => {"booking_id"=>"1"},
    #        :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
    #   to_return(:status => 200, :body => "", :headers => {})

  end
end

prefork = lambda {
  # ...
}

each_run = lambda {
  FactoryGirl.reload
  ActionMailer::Base.deliveries.clear
}

if defined?(Zeus)
  prefork.call
  $each_run = each_run
  class << Zeus.plan
    def after_fork_with_test
      after_fork_without_test
      $each_run.call
    end
    alias_method_chain :after_fork, :test
  end
elsif ENV['spork'] || $0 =~ /\bspork$/
  require 'spork'
  Spork.prefork(&prefork)
  Spork.each_run(&each_run)
else
  prefork.call
  each_run.call
end
