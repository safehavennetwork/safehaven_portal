class GetPetsInNeed
  def self.call
    Pet.where(organization_id: nil).select{ |p| !p.client.organization.blank? }
  end
end
