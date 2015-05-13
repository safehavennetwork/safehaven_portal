class GetCurrentClients
  def self.call(id)
    Client.where(organization_id: id)
  end
end
