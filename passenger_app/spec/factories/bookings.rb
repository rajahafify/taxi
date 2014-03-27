# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    latitude "41.40338"
    longitude "2.17403"
    user
    driver_assigned { false }
    driver_id { nil }

    factory :booking_with_driver do
      driver_assigned { true }
      driver_id { 1 }
    end
  end
end
