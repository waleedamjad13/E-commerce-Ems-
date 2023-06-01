# frozen_string_literal: true

# controller for handling login process of users
module api
  module Users
    #
    # controller for handling login process of users
    #
    class SessionsController < Devise::SessionsController
      # before_action :configure_sign_in_params, only: [:create]

      # GET /resource/sign_in
      # def new
      #   super
      # end

      # POST /resource/sign_in
      def create
        super do |resource|
          redirect_to admin_products_path and return if resource.admin?

          redirect_to root_path and return
        end
      end

      # DELETE /resource/sign_out
      def destroy
        super do |_resource|
          redirect_to new_user_session_path and return
        end
      end

      # protected

      # If you have extra params to permit, append them to the sanitizer.
      # def configure_sign_in_params
      #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
      # end
    end
  end
end
