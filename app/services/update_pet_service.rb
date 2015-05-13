class UpdatePetService
  attr_accessor :errors, :pet, :pet_hash

  def initialize(update_hash)
    @pet_hash = update_hash
  end

  def call
    pet = Pet.find(pet_hash[:id])
    pat_hash[:pet_type] = PetType.find_by(pet_type: pet_hash[:pet_type])
    pet.update_attributes(convert_bools(pet_hash.except(:id, :organization_name)))
  end

  def convert_bools(pet_hash)
    pet = pet_hash.deep_dup
    pet[:spayed]            = pet[:spayed] == 'yes' ? true : false
    pet[:objection_to_spay] = pet[:objection_to_spay] == 'yes' ? true : false
    pet[:microchipped]      = pet[:microchipped] == 'yes' ? true : false
    pet[:vaccinations]      = pet[:vaccinations] == 'yes' ? true : false
    pet
  end
end
