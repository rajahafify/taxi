namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    10.times do |n|
      name  = Faker::Name.name
      phone_number = Faker::PhoneNumber.cell_phone
      latitude = Faker::Address.latitude
      longitude = Faker::Address.longitude
      Driver.create!(name: name,
                   phone_number: phone_number,
                   latitude: latitude,
                   longitude: longitude)
    end
  end
end
