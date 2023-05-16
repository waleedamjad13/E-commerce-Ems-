# frozen_string_literal: true

# interactor for destroy user in admin/users_controller
class DestroyUser < ApplicationInteractor
  def call
    user = User.find(context.id)
    if user.destroy
      context.notice = 'User was successfully deleted.'
    else
      error('Failed to delete user.')
    end
  end
end
