class OrganizationController < ApplicationController
  before_action :authenticate_user!, except: [:sign_up_form, :sign_up]
  skip_before_action :verify_authenticity_token

  def show
    @organization = Organization.friendly.find(params[:id])
  end

  def update
    org = Organization.find(params[:id])
    admin_id = org.users.find_by(email: params.fetch(:user, {})[:email]).try(:id)
    unless org.update_attributes(update_params.merge(admin_id: admin_id))
      flash[:error] = 'Error updating organization'
    end
    flash[:success] = 'Update successful'
    redirect_to organization_path, id: params[:id]
  end

  def update_contact_info
    org = Organization.find(params[:id])
    unless UpdateOrgContactInfo.new(org, update_contact_info_params).call
      flash[:error] = 'Error updating organization contact info'
    end
    flash[:success] = 'Update successful'
    redirect_to organization_path, id: params[:id]
  end

  def dashboard
    render('users/registrations/pending') && return if current_user.disabled
    @dashboard = DashboardFacade.new(current_user).dashboard
    render @dashboard.view
  end

  def accept_client
    client = Client.find(params[:id])
    client.update_attributes( organization: current_user.organization, updated_at: Time.now, update_action: 'accepted')
    UserMailer.client_accepted(client).deliver
    redirect_to client_path params[:id]
  end

  def release_client
    @client = Client.find(params[:id])
    @client.update_attributes(organization: nil, updated_at: Time.now, update_action: 'released', release_status: ReleaseStatus[params[:release_status]] )
    unless @client.all_pets_released?
      OrganizationMailer.client_released_with_active_pets(@client)
    end
    OrganizationMailer.client_released(@client)
    redirect_to :root
  end

  def accept_pets
    unless AcceptPets.new(shelter: current_user.organization, client: Client.find(params[:client_id])).call
      flash[:error] = 'Error accepting pets'
    end
    redirect_to client_path params[:client_id]
  end

  def release_pets
    #client = Client.find(params[:id])
    if ReleasePets.new( shelter: current_user.organization,
                        client:  Client.find(params[:client_id]),
                        reason:  params[:release_status]).call
      redirect_to :root
    else
      flash[:error] = 'Error releasing pets'
      render "client/#{params[:client_id]}"
      #render "client/#{client.client_id}"
    end
  end

  def sign_up_form
    @organization_type = params[:type]
    @params = params
  end

  def sign_up
    @organization_type = params[:type]
    @params = params
    if params[:organization_member] == 'on'
      unless org = Organization.find_by(code: org_lookup_params[:organization_code].upcase)
        flash[:error] = 'The organization code entered could not be found'
        render 'users/registrations/failed' && return
      end

      @user = User.get_user(user_params.merge(organization: org))
      if @user.errors.messages.present?
        flash[:error] = @user.errors.messages.map {|k,v| "#{k.to_s} #{v[0]}"}.join(', ')
        render "organization/sign_up_form" 
      else
      UserMailer.new_user_email.deliver unless Rails.env.development?
      render 'users/registrations/pending'
    end
    else
      unless @org = Organization.create_with_admin(organization_params, user_params)
        flash[:error] = 'Error creating new Organization!'
        render 'users/registrations/failed' && return
      end
      @user = @org.admin
      if @user.errors.messages.present?
        flash[:error] = @user.errors.messages.map {|k,v| "#{k.to_s} #{v[0]}"}.join(', ')
        render "organization/sign_up_form"
      else
        UserMailer.new_user_email.deliver unless Rails.env.development?
        render 'organization/pending_registration'
      end
    end
  rescue => e
    flash[:error] = e.message
    Rails.logger.error(e.message)
    Rails.logger.error(e.backtrace)
    render 'users/registrations/failed'
  end

  def status_update
    return_hash = { status: 'failure' }
    case params[:type]
    when 'user'
      if params[:status] == 'true'
        user = User.find(params[:id])
        unless user.welcome_email_sent
          if user.org_admin?
            UserMailer.new_org_admin_welcome(user).deliver
          else
            UserMailer.new_user_welcome(user).deliver
          end
        end
        return_hash[:status] = 'success' if User.find(params[:id]).update_attributes(disabled: nil, groups: [Group.find_by(name: 'user')], updated_at: Time.now, update_action: 'enabled')
      else
        return_hash[:status] = 'success' if User.find(params[:id]).update_attributes(disabled: Date.today, updated_at: Time.now, update_action: 'disabled')
      end
    when 'advocate', 'shelter'
      if params[:status] == 'true'
        return_hash[:status] = 'success' if Organization.find(params[:id]).update_attributes(disabled: nil, updated_at: Time.now, update_action: 'enabled')
      else
        return_hash[:status] = 'success' if Organization.find(params[:id]).update_attributes(disabled: Date.today, updated_at: Time.now, update_action: 'disabled')
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
      :phone_number,
      :agree_to_terms
    )
  end

  def organization_params
    params.permit(
      :type,
      :organization_name,
      :organization_phone_number,
      :tax_id,
      :email
    )
  end

  def update_params
    params.permit(
      :name,
      :tax_id,
      :phone,
      :email,
      :services,
      :office_hours,
      :website_url,
      :geographic_area_served
    )
  end

  def update_contact_info_params
    params.permit(
      :phone,
      :email,
      address: [
        :line1,
        :line2,
        :city,
        :state,
        :zip_code
      ]
    )
  end
end
