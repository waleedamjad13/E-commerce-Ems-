# frozen_string_literal: true

# controller for products that are for normal users
class ProductsController < ApplicationController
  def index
    @pagy, @products = pagy(Product.all_products(current_user), items: 9)

    @product_views = ProductView.collection(@products)

    return unless params[:search].present?

    @products = @products.search(params[:search])
  
  end

  def show
    @product = Product.find_by(id: params[:id])

    @product_view = ProductView.new(@product, current_user: current_user)
  end
end
