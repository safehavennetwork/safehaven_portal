FactoryGirl.define do
  factory :city do
    city { Faker::Address.city }
  end
end
