FactoryGirl.define do
  factory :state do
    state { Faker::Address.state_abbr }
  end
end
