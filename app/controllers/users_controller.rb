class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @user = User.find params[:id]
  end

  def update
    @user  = User.find(params[:id])
    update = UpdateUser.new(update_params, @user).call
    unless update.errors.empty?
      flash[:notice] = 'Error updating user'
      flash[:status] = 'error'
    end
    redirect_to user_path(@user)
  end

  def update_params
    params.permit(
      :first_name,
      :last_name,
      :email,
      :primary_phone_number,
      :secondary_phone_number
    )
  end
end
