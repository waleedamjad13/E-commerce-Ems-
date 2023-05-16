module Admin
  class UsersController < ApplicationController
    before_action :set_user

    def index
      @users = User.all
    end

    def show
      @user = User.find_by(id: params[:id])
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      result = UpdateUser.call(
        user: @user,
        user_params: user_params
      )

      if result.success?
        redirect_to root_path, notice: 'User was successfully updated.'
      else
        render :edit, notice: result.message
      end
    end

    def destroy
      result = DestroyUser.call(id: params[:id])
      if result.success?
        redirect_to root_path, notice: result.notice
      else
        redirect_to root_path, alert: result.error
      end
    end

    private

    def user_params
      params
        .require(:user)
        .permit(:firstname, :lastname, :email)
    end

    def set_user
      @user = User.find_by(id: params[:id])
      @user ||= User.new
    end
  end
end
