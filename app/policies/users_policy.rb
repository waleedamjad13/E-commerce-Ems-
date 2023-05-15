class UsersPolicy < ApplicationPolicy
  def index
    user.admin?
  end
end
