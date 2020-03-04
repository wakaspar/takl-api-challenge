# spec/factories/items.rb
FactoryBot.define do
  factory :addresses do
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
  end
end
