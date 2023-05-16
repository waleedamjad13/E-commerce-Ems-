# frozen_string_literal: true

module Admin
  # controller for users that are namespaced inside admin
  #
  class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update show destroy]

    def index
      @pagy, @users = pagy(User.all, items: 6)
    end

    def show;    end

    def edit;    end

    def update
      result = UpdateUser.call(
        user: @user,
        user_params: user_params
      )

      if result.success?
        redirect_to root_path, notice: 'User was successfully updated.'
      else
        render :edit, alert: result.error
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
      @user ||= User.new # rubocop:disable Naming/MemoizedInstanceVariableName
    end
  end
end
