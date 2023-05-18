# frozen_string_literal: true

module Admin
  # policy for users inside admin folder
  #
  class UserPolicy < ApplicationPolicy
    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      # def resolve
      #   scope.all
      # end
    end

    def index
      user.admin?
    end
  end
end
