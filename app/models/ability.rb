class Ability
  include CanCan::Ability

  attr_accessor :user

  def initialize(user)
    @user = user

    can :update, User, user_id: user.id

    if user.site_admin?
      can :manage, :all
    end

    if user.shelter?
      can :update, Pet, pet_id: Pet.where(organization_id: org_id).pluck(:pet_id)
      can :update, Organization, organization_id: org_id
    end

    if user.advocate?
      can :update, Pet, pet_id: Client.includes(:pets).where(organization_id: org_id).pluck('pets.pet_id')
      can :update, Client, client_id: Client.where(organization_id: org_id).pluck(:client_id)
      can :update, Organization, organization_id: org_id
    end
  end

  def org_id
    user.organization_id
  end
end
