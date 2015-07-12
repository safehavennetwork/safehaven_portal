require 'rails_helper'

RSpec.feature "adding a new client", js: true do
  let!(:user) { create(:user) }
  let!(:org) { create(:advocate_organization, users: [user]) }

  before do
    login_page.login(user)
  end

  describe "adding a pet to a client" do
    let!(:client) { create(:client, organization: org) }
    let (:pet_type) { create(:pet_type) }
    let (:pet_attributes) { attributes_for(:pet) }

    it "adds the pet" do
      client_edit_page.visit_page(client)
      client_edit_page.add_pet(pet_type, pet_attributes)

      eventually do
        expect(pet_verifier).to have_basic_info(pet_type, pet_attributes)
        expect(client_edit_page).to have_reset_pet_form
      end
    end
  end
end
