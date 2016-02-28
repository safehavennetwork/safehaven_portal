class ClientMailer < ActionMailer::Base
  default from: 'referral@thesafehavennetwork.org'

  def confirm_signup(client)
    mail(to: client.email,  subject: 'signup confirmation')
  end

  def application_completed
    mail(to: (shelter_emails + site_admin_email),  subject: 'signup confirmation')
  end

  def site_admin_email
    ['referral@thesafehavennetwork.org']
  end

  def advocate_emails
    Organization.where(organization_type: OrganizationType['advocate']).pluck(:email).compact
  end

  def shelter_emails
   # Organization.where(organization_type: OrganizationType['shelter']).pluck(:email).compact
   User.joins(:organization).where("organizations.organization_type_id=2").pluck(:email)    
   end
end

  