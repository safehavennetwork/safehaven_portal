class OrganizationPolicy < ApplicationPolicy
   attr_reader :user, :organization

  def initialize(user, organization)
    @user = user
    @organization = organization
  end

  def update?
    user.site_admin? or user.organization = organization
  end

  def show_form?
    user.site_admin? or user.organization = organization
  end
end
