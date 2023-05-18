# frozen_string_literal: true

# controller for products that are for normal users
class ProductsController < ApplicationController
  def index
    @products = Product.all_products(current_user)

    @product_views = ProductView.collection(@products)
  end

  def show
    @product = Product.find_by(id: params[:id])

    @product_view = ProductView.new(@product, current_user: current_user)
  end
end
