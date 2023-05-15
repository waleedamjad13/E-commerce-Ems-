# frozen_string_literal: true

# controller for methods that are used in all controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit::Authorization


  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:firstname, :lastname, :admin, :email, :password,
        :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:firstname, :lastname, :admin, :email, :password,
        :current_password)
    end
  end
end
