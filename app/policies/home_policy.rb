class HomePolicy < ApplicationPolicy

  def index?
    user.admin?
  end
end
