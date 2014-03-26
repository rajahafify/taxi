# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    latitude "41.40338"
    longitude "2.17403"
    user
  end
end
