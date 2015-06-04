class UserMailer < ActionMailer::Base
  default from: 'referral@thesafehavennetwork.org'

  def new_user_email
    mail(to: site_admin_email, subject: 'New user on the Secure Portal')
  end

  def new_user_welcome(user)
    user.update_attributes(welcome_email_sent: Date.today)
    mail(to: user.email, subject: "Safehaven account enabled")
  end

  def new_client(client)
    mail(to: site_admin_email, subject: 'A new client has been submitted')
  end

  def client_accepted(client)
    mail(to: site_admin_email, subject: 'A client has been accepted')
  end

  def pet_accepted(pet)
    mail(to: site_admin_email, subject: 'A pet has been accepted')
  end

  def site_admin_email
    #Rails.env.staging? ? 'safe@thesafehavennetwork.org' : 'adam@themoffatt.com'
    'adam@themoffatt.com'
  end
end
