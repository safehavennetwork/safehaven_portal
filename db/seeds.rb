%w(advocate shelter foster).each do |org_type|
  OrganizationType.find_or_create_by(organization_type: org_type)
end

%w(submitted approved review suspended).each do |org_status|
  OrganizationStatus.find_or_create_by(organization_status: org_status)
end

%w(site_admin org_admin user).each do |group|
  Group.find_or_create_by(name: group)
end

%w(cat dog other).each do |pet_type|
  PetType.find_or_create_by(pet_type: pet_type)
end

user = User.find_or_create_by!(email: 'admin@safehaven.org', password: 'defaultpassword', disabled: nil)

User.find_by(email: 'admin@safehaven.org').groups << Group.find_by(name: 'site_admin')

unless Rails.env.production?

  advocate = User.find_or_create_by!(
    email: 'admin@advocate.org',
    password: 'password',
    disabled: nil,
    organization: Organization.create({
      name:              'Advocate Inc.',
      organization_type: OrganizationType.find_by(organization_type: 'advocate')
    })
  )

  shelter = User.find_or_create_by!(
    email: 'admin@shelter.org',
    password: 'password',
    disabled: nil,
    organization: Organization.create({
      name:              'Shelter Inc.',
      organization_type: OrganizationType.find_by(organization_type: 'shelter')
    })
  )

  advocate.groups << Group.find_by(name: 'org_admin')
  shelter.groups  << Group.find_by(name: 'org_admin')

  Client.create({
    name:  'jane doe',
    email: 'jane@doe.com',
    address: Address.create(
      line1:    '12 S Maple St.',
      city:     City.find_or_create_by(city:        'Chicago'),
      state:    State.find_or_create_by(state:      'IL'),
      zip_code: ZipCode.find_or_create_by(zip_code: '60613')
    )
  })

  Client.first.pets << Pet.create(name: 'mccoy',   breed: 'shepard', weight: '55 lbs', pet_type: PetType.find_by(pet_type: 'dog'))
  Client.first.pets << Pet.create(name: 'houdini', breed: 'cat',     weight: '15 lbs', pet_type: PetType.find_by(pet_type: 'cat'))

end
