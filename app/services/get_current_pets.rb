class GetCurrentPets
  def self.call(id)
    Pet.where(organization_id: id)
  end
end
