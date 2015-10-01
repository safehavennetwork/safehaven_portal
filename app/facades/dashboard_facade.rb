class DashboardFacade
  attr_accessor :dashboard, :user, :org

  def initialize(user)
    @user = user
    @org  = user.organization
  end

  def dashboard
    @dashboard_type ||= send(dashboard_type)
  end

  def admin_dashboard
    OpenStruct.new(defaults.merge({
      pending_users:      User.pending,
      all_users:          User.all.except{ |u| u.email == 'admin@safehaven.org'},
      all_clients:        Client.all,
      recent_activities:  GetRecentActivity.call,
      view:               'admin/dashboard'
    }))
  end

  def advocate_dashboard
    OpenStruct.new(defaults.merge({
      current_clients: GetCurrentClients.call(org.id),
      clients_in_need: GetClientsInNeed.call,
      view:            'organization/advocate/dashboard'
    }))
  end

  def shelter_dashboard
    OpenStruct.new(defaults.merge({
      current_pets: GetCurrentPets.call(org.id),
      pets_in_need: GetPetsInNeed.call,
      view:         'organization/shelter/dashboard'
    }))
  end

  def dashboard_type
    return :admin_dashboard    if user.site_admin?
    return :shelter_dashboard  if user.shelter?
    return :advocate_dashboard if user.advocate?
  end

  def defaults
    {
      org: org,
      user: user
    }
  end
end
