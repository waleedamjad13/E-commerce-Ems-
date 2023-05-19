# frozen_string_literal: true

# UserView class for category show
#
class CategoryView < ApplicationView
  alias category model

  delegate :id, :name, to: :category
end
