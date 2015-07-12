FactoryGirl.define do
  factory :pet_type do
    pet_type { ['dog', 'cat', 'other'].sample }
  end
end
