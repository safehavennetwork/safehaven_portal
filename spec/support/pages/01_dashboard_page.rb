class DashboardPage < Page
  def visit_page(organization)
    visit "/"
    self
  end
end
