class VolunteerMailer < ActionMailer::Base
  #default from: 'referral@thesafehavennetwork.org'
  default from: 'dtest562@gmail.com'

  def new_client(client)
    #mail(to: advocates_and_site_admin,  subject: 'New client on the Secure Portal')
    mail(to: advocate_emails,  subject: 'New client on the Secure Portal')
    mail(cc: site_admin_email,  subject: 'New client on the Secure Portal')
  end

  def advocates_and_site_admin
    advocate_emails + site_admin_email
  end

  def site_admin_email
    #['referral@thesafehavennetwork.org']
    ['dtest562@gmail.com']
  end

  def advocate_emails
    #Organization.where(organization_type: OrganizationType['advocate']).pluck(:email).compact
    User.joins(:organization).where("organizations.organization_type_id = 1").pluck(:email)
  end

  def shelter_emails
    Organization.where(organization_type: OrganizationType['shelter']).pluck(:email).compact
  end
end

