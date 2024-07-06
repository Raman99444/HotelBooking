class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
end
