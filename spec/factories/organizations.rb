FactoryGirl.define do
  factory :organization do
    sequence(:name) { |n| "Organization #{n}" }
    phone { Faker::PhoneNumber.phone_number }
    sequence(:code) { |n| "CODE#{n}" }

    organization_status { OrganizationStatus.create(organization_status: 'submitted') }

    factory :advocate_organization do
      organization_type { OrganizationType.create(organization_type: 'advocate') }
    end
  end
end
