class UpdateUser < ApplicationInteractor
  delegate :user, :user_params, to: :context

  def call
    return if user.update(user_params)

    error(user.errors.full_messages.to_sentence)
  end
end
