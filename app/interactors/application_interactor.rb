# frozen_string_literal: true

#
# Base Interactor
#
class ApplicationInteractor
  include Interactor

  private

  def error(message)
    context.fail!(error: message)
  end

  def custom_label(user, key)
    user.account.settings.custom_label(key)
  end
end