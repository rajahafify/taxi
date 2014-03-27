# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :driver do
    name Faker::Name.name
    phone_number Faker::PhoneNumber.cell_phone
    latitude Faker::Address.latitude
    longitude Faker::Address.longitude
  end
end
