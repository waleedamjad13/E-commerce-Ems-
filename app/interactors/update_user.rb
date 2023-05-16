# frozen_string_literal: true

# interactor for user update that is in admin/users_controller.rb
class UpdateUser < ApplicationInteractor
  delegate :user, :user_params, to: :context

  def call
    return if user.update(user_params)

    error(user.errors.full_messages.to_sentence)
  end
end
