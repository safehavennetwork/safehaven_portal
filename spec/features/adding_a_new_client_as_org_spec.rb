=begin
require 'rails_helper'

RSpec.feature "adding a new client", js: true do
  let!(:user) { create(:user) }
  let!(:org) { create(:advocate_organization, users: [user]) }

  before do
    login_page.login(user)
  end

  describe "adding a new client" do
    let (:client_attributes) { attributes_for(:client) }
    let (:client_address_attributes) { attributes_for(:address) }
    let (:client_address_city_attributes) { attributes_for(:city) }
    let (:client_address_state_attributes) { attributes_for(:state) }
    let (:client_address_zip_code_attributes) { attributes_for(:zip_code) }

    let!(:pet_type) { create(:pet_type) }
    let (:pet_attributes) { attributes_for(:pet) }

    it "adds the pet" do
      advocate_dashboard_page.visit_page(org)
      advocate_dashboard_page.add_new_client

      client_new_page.fill_client_fields(client_attributes)
      client_new_page.fill_address_fields(
        client_address_attributes,
        client_address_city_attributes,
        client_address_state_attributes,
        client_address_zip_code_attributes
      )

      client_new_page.add_pet(pet_type, pet_attributes)

      expect(client_new_page).to have_reset_pet_form

      client_new_page.add_to_organization
      client_new_page.submit_form

      eventually do
        client = Client.last

        client_verifier = ClientVerifier.new(client)
        address_verifier = AddressVerifier.new(client.address)
        pet_verifier = PetVerifier.new(client.pets.first)

        expect(client.organization).to eq(org)
        expect(client_verifier).to have_basic_info(client_attributes)
        expect(address_verifier).to have_basic_address(
          client_address_attributes,
          client_address_city_attributes,
          client_address_state_attributes,
          client_address_zip_code_attributes
        )
        expect(pet_verifier).to have_basic_info(pet_type, pet_attributes)
      end
    end
  end
end
=end
