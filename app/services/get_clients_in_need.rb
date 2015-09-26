class GetClientsInNeed
  def self.call
    Client.where(organization_id: nil).includes(:pets, address: :zip_code)
  end
end
