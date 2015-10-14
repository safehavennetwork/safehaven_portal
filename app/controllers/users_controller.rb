class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def show
    @user = User.friendly.find params[:id]
  end

  def update
    @user  = User.find(params[:id])
    update = UpdateUser.new(update_params, @user).call
    unless update.errors.empty?
      flash[:error] = 'Error updating user'
    end
    redirect_to user_path(@user)
  end

   def update_password
    @user = User.find(current_user.id)
    if @user.valid_password?(params[:user][:current_password]) && @user.update(update_password_params)
      sign_in @user, :bypass => true
      flash[:success] = 'Password updated!'
    else
      flash[:error] = 'Error updating password'
    end
    redirect_to user_path(@user)
  end

  def update_password_params
    params.require(:user).permit(:password, :password_confirmation)
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
