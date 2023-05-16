# frozen_string_literal: true

# UserView class for users show
#
class UserView < ApplicationView
  alias user model

  delegate :firstname, :lastname, :email, :admin?, :confirmed?, to: :user
end
