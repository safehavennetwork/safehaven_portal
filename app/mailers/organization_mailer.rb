class OrganizationMailer < ActionMailer::Base
  default from: 'referral@thesafehavennetwork.org'

  def pets_accepted(client)
    @client = client
    mail(to: [client.organization.email] + site_admin_email,  subject: 'Pets Accepted')
  end

  def pets_released(client)
    @client = client
    mail(to: [client.organization.email] + site_admin_email,  subject: 'Pets Released')
  end

  def client_released_with_active_pets(client)
    @client = client
    mail(to: [client.organization.email] + site_admin_email,  subject: 'Client released with active pets')
  end

  def client_released(client)
    @client = client
    mail(to: site_admin_email,  subject: 'Client released')
  end

  def site_admin_email
    ['referral@thesafehavennetwork.org']
  end

  def advocate_emails
    Organization.where(organization_type: OrganizationType['advocate']).pluck(:email).compact
  end

  def shelter_emails
    Organization.where(organization_type: OrganizationType['shelter']).pluck(:email).compact
  end
end
