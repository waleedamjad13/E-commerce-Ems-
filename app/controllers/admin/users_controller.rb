# frozen_string_literal: true

require 'prawn'
require 'pdf-reader'

module Admin
  # controller for users that are namespaced inside admin
  #
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    def index
      @pagy, @users = pagy(User.non_admins, items: 5)

      return unless params[:search].present? # rubocop:disable  Rails/Blank

      @users = @users.search_by_name(params[:search])
    end

    def show; end

    def edit; end

    def update
      result = UpdateUser.call(
        user: @user,
        user_params: user_params
      )

      if result.success?
        redirect_to admin_user_path, notice: 'User was successfully updated.'
      else
        render :edit, alert: result.error
      end
    end

    def destroy
      result = DestroyUser.call(id: params[:id])

      if result.success?
        redirect_to admin_users_path, notice: result.notice
      else
        redirect_to admin_users_path, alert: result.error
      end
    end

    def export
      result = ExportUsers.call(search_terms: params[:search])

      if result.success?
        send_data result.csv_data, filename: result.filename
      else
        redirect_to root_path, alert: result.error
      end
    end

    private

    def user_params
      params
        .require(:user)
        .permit(:firstname,
          :lastname,
          :email,
          :password,
          :password_confirmation)
    end

    def set_user
      @user = User.find_by(id: params[:id])
      @user ||= User.new

      @user_view = UserView.new(@user, current_user: current_user)
    end
  end
end
