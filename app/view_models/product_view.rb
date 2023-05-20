# frozen_string_literal: true

# UserView class for users show
#
class ProductView < ApplicationView
  alias product model

  delegate :title, :description, :price, :status, :header_image, :category_id, :images,
    to: :product


  def category_options
    Category.all.map { |category| [category.id, category.name]}
  end

end
