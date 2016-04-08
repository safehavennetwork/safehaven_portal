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
    @pet = Pet.find(params[:id])
    if update_service.success?
      @pet.update_attributes(completed: true)
    end

    client = @pet.client
    unless client.all_pets_complete?
      @pet = client.pets.find_by(completed: [nil, false])
      #redirect_to apply_pet_details_path(id: pet.id)
      redirect_to apply_client_details_path(id: client.id)
    else
      redirect_to apply_client_details_path(id: client.id)
    end
  end

  def client
    @client = Client.find(params[:id])
    render 'apply/client_application'
  end

  def update_client_application
    @client = Client.find(params.permit(:id)[:id])
    if @client.client_application
      @client.client_application.update_attributes(client_application_params)
    else
      @client.update_attributes(client_application: ClientApplication.create(client_application_params))
    end
    redirect_to application_review_path(id: @client.id)
  end

  def review
    @client = Client.find params[:id]
  end

  def confirm
    ClientMailer.application_completed.deliver
    redirect_to root_path
  end

  def client_application_params
    params.permit([
      :client_id                   ,
      :status                      ,
      :abuser_visiting_spots       ,
      :estimated_length_of_housing ,
      :police_involved             ,
      :protective_order            ,
      :pet_protective_order        ,
      :client_legal_owner_of_pet   ,
      :abuser_legal_owner_of_pet   ,
      :abuser_notes                ,
      :explored_boarding_options
    ])
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
