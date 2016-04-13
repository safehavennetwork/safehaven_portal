class ClientController < ApplicationController
  include ClientHelper

  before_action :authenticate_user!, except: [:short_form, :anonymous_signup]
  skip_before_action :verify_authenticity_token

  def show
    @client = Client.includes(:pets, :client_application).friendly.find(params.permit(:id)[:id])
    unless @client.application_completed?
      if @client.pets.present?
        @apply_url = apply_pet_details_path(@client.pets.first.id)
      else
        @apply_url = apply_client_details_path(@client)
      end
    end
  end

  def anonymous_signup
    if @client = CreateClientWithPets.call(client_params, params[:pets])
      unless Rails.env.development?
        VolunteerMailer.new_client(@client).deliver
        ClientMailer.confirm_signup(@client).deliver if params[:confirmation_email]
      end
      render 'client/signup_confirmation'
    else
      flash[:status] = 'error'
      flash[:notice] = 'Error during sign up'
      render 'client/short_form'
    end
  end

  def update
    @client = Client.find(params.permit(:id)[:id])
    client_hash = client_params
    client_hash[:address] = GetAddress.call(address_params[:address])
    client_hash[:phone_number] = PhoneNumber.find_or_create_by(phone_number: client_params[:phone_number])
    @client.update_attributes(client_hash)

    redirect_to :back and return if apply_review?
    redirect_to "/client/#{@client.id}"
  end

  def client_application_update
    @client = Client.find(params.permit(:id)[:id])
    if @client.client_application
      @client.client_application.update_attributes(client_application_params)
    else
      @client.update_attributes(client_application: ClientApplication.create(client_application_params))
    end
    redirect_to :back and return if apply_review?
    redirect_to "/client/#{@client.id}"
  end

  def new_pet
    @client = Client.find(params.permit(:id)[:id])
    pet_hash = new_pet_params
    pet_hash[:pet_type] = PetType.find_by(pet_type: pet_hash[:pet_type])
    @client.pets << Pet.find_or_create_by(pet_hash)
    redirect_to :back and return if apply_review?
    redirect_to "/client/#{@client.id}"
  end

  def new_client_form
    @org_id = current_user.organization_id
  end

  def new
    @client_hash = client_params
    @org         = current_user.organization
    @new_client  = CreateClientWithPets.call(client_params, params[:pets], @org)
    redirect_to apply_pet_details_path(id: @new_client.pets.first.id)
  rescue => e
    render 'shared/oops'
  end

  def address_params
    params.permit(
      address: [
        :line1,
        :city,
        :state,
        :zip_code
      ]
    )
  end

  def new_pet_params
    params.permit(:pet_type, :breed, :weight)
  end

  def client_params
    params.permit(
      :name,
      :phone_number,
      :email,
      :best_way_to_reach,
      address: [
        :line1,
        :city,
        :state,
        :zip_code
      ]
    )
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
end
