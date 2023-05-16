# frozen_string_literal: true

require 'prawn'
require 'pdf-reader'

module Admin
  # controller for users that are namespaced inside admin
  #
  class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update show destroy]

    def index
      @pagy, @users = pagy(User.all, items: 6)

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
        .permit(:firstname, :lastname, :email)
    end

    def set_user
      @user = User.find_by(id: params[:id])
      @user ||= User.new # rubocop:disable Naming/MemoizedInstanceVariableName
      # @user_view = UserView.new
    end
  end
end
