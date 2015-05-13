class Organization < ActiveRecord::Base

  belongs_to :organization_type
  belongs_to :organization_status
  belongs_to :address
  belongs_to :admin, class_name: 'User'
  has_many   :users

  def self.get_organization(org_hash)
    return organization if organization = Organization.find_by(code: org_hash['organization_code'])

    org_hash[:name]  = org_hash.delete(:organization_name)
    org_hash[:phone] = org_hash.delete(:organization_phone_number)
    org_hash[:organization_type]   = OrganizationType.find_or_create_by(organization_type: org_hash.delete(:type))
    org_hash[:organization_status] = OrganizationStatus.find_or_create_by(organization_status: org_hash.delete(:type))
  end

  def self.create_with_admin(org_hash, user_hash)
    org = Organization.create!(
      name:              org_hash[:organization_name],
      phone:             PhoneNumber.find_or_create_by!(phone_number: org_hash[:organization_phone_number]),
      admin:             User.get_user(user_hash),
      organization_type: OrganizationType.find_by(organization_type: org_hash[:type])
    )
    # FIXME: ugh
    org.admin.update_attributes(organization: org)
    org
  end
end
