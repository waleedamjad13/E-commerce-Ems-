# frozen_string_literal: true

# controller for products that are for normal users
module api
  class ProductsController < ApplicationController
    before_action :authenticate_user!
    def index
      @pagy, @products = pagy(Product.all_products(current_user), items: 9)

      @products = if params[:search].present?
                    @products.search(params[:search], current_user)
                  else
                    sorting
                  end

      @product_views = ProductView.collection(@products)
    end

    def show
      @product = Product.find_by(id: params[:id])

      @product_view = ProductView.new(@product, current_user: current_user)
    end

    private

    def sorting
      column = params[:column] || 'title'
      direction = params[:direction] || 'asc'

      @products.order("#{column.to_sym} #{direction.to_sym.upcase}")
    end
  end
end
