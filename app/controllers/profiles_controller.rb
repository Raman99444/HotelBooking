class ProfilesController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_devise_mapping
  layout 'dashboard'

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    processed_params = user_params

    if processed_params[:password].blank?
      processed_params.delete(:password)
      processed_params.delete(:password_confirmation)
    end

    if @user.update_with_password(processed_params)
      bypass_sign_in(@user)
      redirect_to profile_path, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :birthday, :gender, :address, :pincode, :state, :email, :password, :password_confirmation, :current_password)
  end

  #def set_devise_mapping
  #  @request.env["devise.mapping"] = Devise.mappings[:user]
  #end
end
