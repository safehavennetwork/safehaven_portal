class ClientNewPage < Page
  def visit_page(organization)
    visit "/organization/#{organization.id}/new_client"
    self
  end

  def submit_form
    find(".qa-submit-form").click
  end

  def fill_client_fields(client_attributes)
    find(".qa-client-name").set(client_attributes[:name])
    find(".qa-client-phone").set(client_attributes[:phone])
    find(".qa-client-email").set(client_attributes[:email])
    find(".qa-client-best-way-to-reach").set(client_attributes[:best_way_to_reach])
  end

  def fill_address_fields(client_address_attributes, client_address_city_attributes, client_address_state_attributes, client_address_zip_code_attributes)
    find(".qa-client-address-line-1").set(client_address_attributes[:line1])
    find(".qa-client-address-city").set(client_address_city_attributes[:city])
    find(".qa-client-address-state").set(client_address_state_attributes[:state])
    find(".qa-client-address-zip-code").set(client_address_zip_code_attributes[:zip_code])
  end

  def add_to_organization
    find(".qa-add-to-org").set(true)
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
