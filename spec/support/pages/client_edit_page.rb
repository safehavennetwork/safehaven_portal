class ClientEditPage < Page
  def visit_page(client)
    visit "/client/#{client.id}"
    self
  end

  def add_pet(pet_type, pet_attributes)
    find(".qa-pet-type").select(pet_type.pet_type.titleize)
    find(".qa-pet-breed").set(pet_attributes[:breed])
    find(".qa-pet-weight").set(pet_attributes[:weight])
    find(".qa-add-pet-btn").click
  end

  def has_reset_pet_form?
    [
      has_pet_type?('dog'),
      has_breed?(''),
      has_weight?('')
    ].all?
  end

  private

  def has_pet_type?(value)
    find(".qa-pet-type").value == value
  end

  def has_breed?(value)
    find(".qa-pet-breed").value == value
  end

  def has_weight?(value)
    find(".qa-pet-weight").value == value
  end
end
