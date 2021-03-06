class GetPetsInNeed
  def self.call
    pets_not_admitted = ReleaseStatus.find_by(release_status: "not_admitted")
    release_status = [nil, pets_not_admitted.id]
    #Client.includes(:pets, pets: :pet_type).where.not(organization: nil, pets_count: 0, name: nil).where('pets.organization' => nil, 'pets.release_status_id' => nil).map do |c|
    Client.includes(:pets, pets: :pet_type).where.not(organization: nil, pets_count: 0, name: nil).where('pets.organization' => nil, 'pets.release_status_id' => release_status ).map do |c|
      @pets = c.pets
      OpenStruct.new({
        client_id: (c.slug || c.id),
        client_name: c.name,
        pet_count: c.pets.size,
        breeds:    breeds,
        types:     types,
        weights:   weights
      })
    end
  end

  def self.breeds
    formatted @pets.map(&:breed)
  end

  def self.types
    formatted @pets.map{|p| p.pet_type.try(:pet_type)}
  end

  def self.weights
   formatted @pets.map(&:weight)
  end

  def self.formatted arr
    arr.uniq.compact.join(', ')
  end
end
