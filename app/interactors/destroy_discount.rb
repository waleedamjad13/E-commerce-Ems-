# frozen_string_literal: true

# interactor for destroy discount
class DestroyDiscount < ApplicationInteractor
  delegate :discount, to: :context

  def call
    return if discount.destroy

    error(discount.errors.full_messages.to_sentence)
  end
end
