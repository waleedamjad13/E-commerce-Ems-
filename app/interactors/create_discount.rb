class CreateDiscount < ApplicationInteractor
  delegate :discount, :discount_params, to: :context

  def call
    context.discount = Discount.new(discount_params)
    return if discount.save

    error(discount.errors.full_messages.to_sentence)
  end
end
