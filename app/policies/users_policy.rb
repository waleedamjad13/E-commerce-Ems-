# frozen_string_literal: true

# policy for users_controller
class UsersPolicy < ApplicationPolicy
  def index
    user.admin?
  end
end
