# frozen_string_literal: true

# UserView class for users show
#
class ProductView < ApplicationView
  alias product model

  delegate :title, :description, :price, :status, :header_image, :category_id,
    :images, to: :product

  def status_options
    Product.statuses.keys.map { |s| [s.titleize, s] }
  end

  def category_options
    Category.all.map { |category| [category.name, category.id] }
  end

  def all_images
    [header_image] + images
  end
end
