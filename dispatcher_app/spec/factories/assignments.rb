# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    booking_id 1
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
    driver_id 1
  end
end
