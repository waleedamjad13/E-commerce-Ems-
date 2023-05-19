# frozen_string_literal: true

# interactor for creating category
class CreateCategory < ApplicationInteractor
  delegate :category, :category_params, to: :context

  def call
    context.category = Category.new(category_params)
    return if category.save

    error(product.errors.full_messages.to_sentence)
  end
end
