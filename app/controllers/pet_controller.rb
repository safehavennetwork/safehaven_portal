class PetController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def show
    @pet = Pet.find(pet_id_param)
    @pet_type = @pet.pet_type.pet_type
  end

  def update
    update_service = UpdatePet.new(update_params)
    @pet           = update_service.call
    set_flash('failure', 'Failed to update pet') unless @pet.errors.blank?
    flash = set_flash('success', 'Pet has been updated!')
    render action: 'show'
  end

  def set_flash(status, message)
    flash[:status]  = status
    flash[:message] = message
  end

  def delete
    if Pet.delete(pet_id_param)
      render json: { status: 'success' }
    else
      render json: { status: 'failure' }
    end
  rescue => e
    render json: { status: 'failure' }
  end

  def update_params
    params.permit(
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
      :additional_info,
      :organization_name
    )
  end

  def pet_id_param
    params.permit(:id)[:id]
  end
end
