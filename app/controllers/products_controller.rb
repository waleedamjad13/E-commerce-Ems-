class ProductsController < ApplicationController
  def index
    @products = Product.all_products(current_user)
  end
end
