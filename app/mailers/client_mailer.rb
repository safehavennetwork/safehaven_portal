class ClientMailer < ActionMailer::Base
  default from: 'referral@thesafehavennetwork.org'

  def confirm_signup(client)
    mail(to: client.email,  subject: 'signup confirmation')
  end
end

