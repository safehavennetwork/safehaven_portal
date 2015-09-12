class GetCurrentPets
  def self.call(id)
    Client.includes(:pets, pets: :pet_type).where('pets.organization' => id).map do |c|
      @pets = c.pets
      OpenStruct.new({
        client_id: c.id,
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
