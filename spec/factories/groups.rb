FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    description { Faker::Lorem.paragraphs(2).join("\n\n") }
  end
end
