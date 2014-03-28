# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assignment do
    booking_id 1
    driver_id nil

    factory :assignment_with_driver do
      driver_id 1
    end
  end
end
