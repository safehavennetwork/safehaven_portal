FactoryGirl.define do
  factory :client do
    name { [Faker::Name.first_name, Faker::Name.last_name].join(' ') }
    phone { Faker::PhoneNumber.phone_number }
    sequence(:email) { |n| "email#{n}@example.com" }
    best_way_to_reach { 'Email' }
    address
  end
end
