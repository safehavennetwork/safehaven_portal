class ApplyController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def new
    @org_id = current_user.organization.id
    render 'client/new_client_form'
  end

  def pet
    @pet = Pet.find(params[:id])
    render 'apply/update_pet'
  end

  def update_pet
    update_service = UpdatePet.new(pet_update_params)
    update_service.call
    pet = Pet.find(params[:id])
    if update_service.success?
      pet.update_attributes(completed: true)
    end

    client = pet.client
    unless client.all_pets_complete?
      pet = client.pets.find_by(completed: [nil, false])
      redirect_to apply_pet_details_form_path(id: pet.id)
    else
      redirect_to client_path(id: client.id)
    end
  end

  def pet_update_params
    pet_hash = params.permit([
      :id,
      :name,
      :pet_type,
      :breed,
      :weight,
      :age,
      :reported,
      :client_id,
      :description,
      :microchipped,
      :micro_chip_id,
      :abuser_at_mid_address,
      :vaccinations,
      :spayed,
      :objection_to_spay,
      :dietary_needs,
      :vet_needs,
      :temperament,
      :additional_info
    ])
  end
end