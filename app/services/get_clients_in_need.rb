class GetClientsInNeed
  def self.call
    Client.where(organization_id: nil)
  end
end
