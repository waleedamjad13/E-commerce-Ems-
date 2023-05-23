# frozen_string_literal: true

# interactor for update discount
class UpdateDiscount < ApplicationInteractor
  delegate :discount, :discount_params, to: :context

  def call
    return if discount.update(discount_params)

    error(discount.errors.full_messages.to_sentence)
  end
end
