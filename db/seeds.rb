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

user = User.find_or_create_by!(email: 'admin@safehaven.org', password: 'defaultpassword')

User.find_by(email: 'admin@safehaven.org').groups << Group.find_by(name: 'site_admin')
