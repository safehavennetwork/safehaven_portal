FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "email#{n}@example.com" }

    password { "password" }
    password_confirmation { "password" }

    disabled { nil }

    association :primary_phone_number, factory: :phone_number
    association :secondary_phone_number, factory: :phone_number
  end
end
