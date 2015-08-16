class UpdatePet
  attr_accessor :errors, :pet, :pet_hash

  def initialize(update_hash)
    @pet_hash = update_hash
  end

  def call
    pet = Pet.find(pet_hash[:id])
    pet_hash['pet_type']     = PetType.find_by(pet_type: pet_hash['pet_type'])
    pet_hash[:updated_at]    = Time.now
    pet_hash[:update_action] = 'updated'
    pet.update_attributes(convert_bools(pet_hash.except(:id, :organization_name)))
    pet
  rescue => e
    @errors = pet.errors
    pet
  end

  def success?
    !errors.present?
  end

  def convert_bools(pet_hash)
    pet = pet_hash.deep_dup
    pet[:spayed]                = true_or_false( pet[:spayed] )
    pet[:objection_to_spay]     = true_or_false( pet[:objection_to_spay] )
    pet[:microchipped]          = true_or_false( pet[:microchipped] )
    pet[:vaccinations]          = true_or_false( pet[:vaccinations] )
    pet[:abuser_at_mid_address] = true_or_false( pet[:abuser_at_mid_address] )
    pet
  end

  def true_or_false(val)
    val == 'yes' ? true : false
  end
end
