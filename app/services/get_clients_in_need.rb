class GetClientsInNeed
  def self.call
    Client.where(organization_id: nil, release_status: nil).includes(:pets, address: :zip_code) +
      Client.where(organization_id: nil, release_status: ReleaseStatus['services-not-provided']).includes(:pets, address: :zip_code)
  end
end
