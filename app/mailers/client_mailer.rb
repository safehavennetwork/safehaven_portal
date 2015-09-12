class VolunteerMailer < ActionMailer::Base
  default from: 'referral@thesafehavennetwork.org'

  def confirm_signup(client)
    mail(to: client.email,  subject: 'signup confirmation')
  end

  def site_admin_email
    'safe@thesafehavennetwork.org'
  end
end

