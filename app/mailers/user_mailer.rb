class UserMailer < ActionMailer::Base
  default from: 'referral@thesafehavennetwork.org'

  def new_user_email
    mail(to: 'adam@themoffatt.com', subject: 'New user on the Secure Portal')
  end
end
