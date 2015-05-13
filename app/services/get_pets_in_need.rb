class GetPetsInNeed
  def self.call
    Pet.where(organization_id: nil)
  end
end
