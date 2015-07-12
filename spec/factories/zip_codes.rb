FactoryGirl.define do
  factory :zip_code do
    zip_code { Faker::Address.zip_code }
  end
end
