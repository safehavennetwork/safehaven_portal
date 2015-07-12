class ClientEditPage < Page
  def visit_page(client)
    visit "/client/#{client.id}"
    self
  end

  
end
