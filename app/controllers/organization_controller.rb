class OrganizationController < ApplicationController
  before_action :authenticate_user!, except: [:sign_up_form, :sign_up]
  skip_before_action :verify_authenticity_token

  def dashboard
    @user            = current_user
    @org             = current_user.organization

    render('users/registrations/pending') && return if current_user.disabled

    if current_user.site_admin?
      @pending_users = User.pending
      @all_users     = User.all
      render 'admin/dashboard'
    else
      if current_user.with_shelter?
        @current_pets = GetCurrentPets.call(@org.id)
        @pets_in_need = GetPetsInNeed.call
        render 'organization/shelter/dashboard'
      else
        @current_clients = GetCurrentClients.call(@org.id)
        @clients_in_need = GetClientsInNeed.call
        render 'organization/advocate/dashboard'
      end
    end
  end

  def accept_client
    Client.find(params[:id]).update_attributes(organization: current_user.organization, updated_at: Time.now, update_action: 'accepted')
    redirect_to :root
  end

  def release_client
    Client.find(params[:id]).update_attributes(organization: nil, updated_at: Time.now, update_action: 'released' )
    redirect_to :root
  end

  def accept_pet
    Pet.find(params[:id]).update_attributes(organization: current_user.organization, updated_at: Time.now, update_action: 'accepted' )
    redirect_to :root
  end

  def release_pet
    Pet.find(params[:id]).update_attributes(organization: nil, updated_at: Time.now, update_action: 'released' )
    redirect_to :root
  end

  def sign_up_form
    @organization_type = params[:type]
  end

  def sign_up
    @type = params[:type]
    if params[:organization_member] == 'on'
      unless org = Organization.find_by(org_lookup_params)
        render 'users/registration/failed'
      end

      unless @user = User.get_user(user_params.merge(organization: org))
        @errors = user.errors.messages
        render 'users/registrations/failed'
      end
      UserMailer.new_user_email.deliver
      render 'users/registrations/pending'
    else
      unless @org = Organization.create_with_admin(organization_params, user_params)
        @errors = @org.errors.messages

        render 'users/registrations/pending'
      end
      @user = @org.admin
      UserMailer.new_user_email.deliver
      render 'organization/pending_registration'
    end
  rescue => e
    Rails.logger.error(e.message)
    Rails.logger.error(e.backtrace)
    render 'users/registrations/failed'
  end

  def status_update
    return_hash = { status: 'failure' }
    case params[:type]
    when 'user'
      if params[:status] == 'true'
        return_hash[:status] = 'success' if User.find(params[:id]).update_attributes(disabled: nil, groups: [Group.find_by(name: 'user')])
      else
        return_hash[:status] = 'success' if User.find(params[:id]).update_attributes(disabled: Date.today)
      end
    when 'advocate', 'shelter'
      if params[:status] == 'true'
        return_hash[:status] = 'success' if Organization.find(params[:id]).update_attributes(disabled: nil)
      else
        return_hash[:status] = 'success' if Organization.find(params[:id]).update_attributes(disabled: Date.today)
      end
    else
    end

    render json: return_hash
  end

  def org_lookup_params
    params.permit(:organization_code)
  end

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :phone_number
    )
  end

  def organization_params
    params.permit(
      :type,
      :organization_name,
      :organization_phone_number
    )
  end
end
