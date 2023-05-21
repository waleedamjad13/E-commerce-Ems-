# frozen_string_literal: true

# interactor for update category
class UpdateCategory < ApplicationInteractor
  delegate :category, :category_params, to: :context

  def call
    return if category.update(category_params)

    error(category.errors.full_messages.to_sentence)
  end
end
