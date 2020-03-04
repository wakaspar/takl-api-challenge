# spec/factories/routes.rb
FactoryBot.define do
  factory :route do
    provider { Faker::Internet.uuid }
    geo_coordinates {[ Faker::Address.latitude, Faker::Address.longitude ]}
    addresses { Faker::Address.street_address }
  end
end
