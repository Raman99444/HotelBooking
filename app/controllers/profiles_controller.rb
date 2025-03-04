class ProfilesController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def show
    @user = current_user
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
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

    respond_to do |format|
      if @user.update_with_password(processed_params)
        bypass_sign_in(@user)
        format.html { redirect_to profile_path, notice: 'Profile updated successfully' }
        format.json { render json: @user, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :birthday, :gender, :address, :pincode, :state, :email, :password, :password_confirmation, :current_password)
  end
end
