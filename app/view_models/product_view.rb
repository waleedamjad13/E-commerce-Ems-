# frozen_string_literal: true

# UserView class for users show
#
class ProductView < ApplicationView
  alias product model

  delegate :title, :description, :price, :status, to: :product
end
