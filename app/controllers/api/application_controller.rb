# frozen_string_literal: true

# controller for methods that are used in all controllers
module api
  class ApplicationController < ActionController::API
    include AuthorizeUser
    include PagyHelpers
    include AdminNamespace

    before_action :set_user_view

    private

    def set_user_view
      @user_view = UserView.new(current_user, current_user: current_user)
    end
  end
end