# frozen_string_literal: true

module Users
  #
  # controller for handling invitaions to user by admin
  #
  class InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters

    protected

    # Permit the new params here.
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:invite,
        keys: %i[firstname lastname email])
    end
  end
end
