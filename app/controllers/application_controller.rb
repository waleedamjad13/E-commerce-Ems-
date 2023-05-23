# frozen_string_literal: true

# controller for methods that are used in all controllers
class ApplicationController < ActionController::Base
  include AuthorizeUser
  include PagyHelpers
  include AdminNamespace
  include InitializeCart

  before_action :set_user_view
  before_action :current_cart

  private

  def set_user_view
    @user_view = UserView.new(current_user, current_user: current_user)
  end
end
