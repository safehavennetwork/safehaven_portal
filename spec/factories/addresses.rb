FactoryGirl.define do
  factory :address do
    line1 { Faker::Address.street_address }
    line2 { Faker::Address.secondary_address }
    city
    state
    zip_code
  end
end
