FactoryGirl.define do
  factory :pet do
    name { Faker::Name.first_name }
    breed { ["Orange", "Red", "Brown", "Yellow"].sample }
    weight { (8..150).to_a.sample }
  end
end
