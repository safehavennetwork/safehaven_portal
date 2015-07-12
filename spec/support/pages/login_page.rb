class LoginPage < Page
  def visit_page
    visit "/users/sign_in"
    self
  end

  def login(user)
    visit_page
    find(".qa-email").set(user.email)
    find(".qa-password").set(user.password)
    find(".qa-login-submit").click
    find(".qa-sign-out")
    self
  end
end
