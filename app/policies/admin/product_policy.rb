# frozen_string_literal: true

module Admin
  # policy for products inside admin folder
  class ProductPolicy < ApplicationPolicy
    class Scope < Scope
      # NOTE: Be explicit about which records you allow access to!
      # def resolve
      #   scope.all
      # end
    end

    def index?
      user.admin?
    end

    def show?
      user.admin?
    end

    def create?
      user.admin?
    end

    def new?
      create?
    end

    def update?
      user.admin?
    end

    def edit?
      update?
    end

    def destroy?
      user.admin?
    end
  end
end
