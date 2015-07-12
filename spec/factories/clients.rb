FactoryGirl.define do
  factory :client do
    name { [Faker::Name.first_name, Faker::Name.last_name].join(' ') }
    phone { Faker::PhoneNumber.phone_number }
    sequence(:email) { |n| "email#{n}@example.com" }
    best_way_to_reach { 'Email' }
    address
  end
end

# t.string   "name",              limit: 191
# t.string   "phone",             limit: 191
# t.string   "email",             limit: 191
# t.string   "best_way_to_reach", limit: 191
# t.integer  "address_id",        limit: 8
# t.datetime "created_at"
# t.integer  "organization_id"
# t.date     "updated_at"
# t.text     "update_action"

# Client.create({
#   name:  'jane doe',
#   email: 'jane@doe.com',
#   address: Address.create(
#     line1:    '12 S Maple St.',
#     city:     City.find_or_create_by(city:        'Chicago'),
#     state:    State.find_or_create_by(state:      'IL'),
#     zip_code: ZipCode.find_or_create_by(zip_code: '60613')
#   )
# })
#
# Client.first.pets << Pet.create(name: 'mccoy',   breed: 'shepard', weight: '55 lbs', pet_type: PetType.find_by(pet_type: 'dog'))
# Client.first.pets << Pet.create(name: 'houdini', breed: 'cat',     weight: '15 lbs', pet_type: PetType.find_by(pet_type: 'cat'))
