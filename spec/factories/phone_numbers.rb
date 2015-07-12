FactoryGirl.define do
  factory :phone_number do
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
