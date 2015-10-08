class UpdatePet
  attr_accessor :errors, :pet, :pet_hash

  def initialize(update_hash)
    @pet_hash = update_hash.except(:id, :organization_name)
    @pet      = Pet.find(update_hash[:id])
  end

  def call
    pet_hash[:pet_type]      = PetType[pet_hash.delete('pet_type')]
    pet_hash[:updated_at]    = Time.now
    pet_hash[:update_action] = 'updated'

    pet_hash[:spayed]                = true_or_false( pet_hash[:spayed] )
    pet_hash[:objection_to_spay]     = true_or_false( pet_hash[:objection_to_spay] )
    pet_hash[:microchipped]          = true_or_false( pet_hash[:microchipped] )
    pet_hash[:vaccinations]          = true_or_false( pet_hash[:vaccinations] )
    pet_hash[:abuser_at_mid_address] = true_or_false( pet_hash[:abuser_at_mid_address] )
    pet.update(pet_hash)
    pet
  rescue => e
    @errors = pet.errors
    pet
  end

  def success?
    !errors.present?
  end

  def true_or_false(val)
    val == 'yes' ? true : false
  end
end
