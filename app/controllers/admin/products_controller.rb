# frozen_string_literal: true

module Admin
  # controller for products that are namespaced inside admin
  #
  class ProductsController < ::ProductsController
    before_action :set_product, only: %i[edit update destroy]
    before_action :authorize_admin

    # GET /products/new
    def new
      @product = Product.new
    end

    # GET /products/1/edit
    def edit; end

    # POST /products or /products.json
    def create
      result = CreateProduct.call(product_params: product_params)

      if result.success?
        redirect_to admin_products_path,
          notice: 'Product was successfully created.'
      else
        @product = result.product
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /products/1 or /products/1.json
    def update
      result = UpdateProduct.call(
        product: @product,
        product_params: product_params
      )

      if result.success?
        redirect_to admin_product_path(@product),
          notice: 'Product was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /products/1 or /products/1.json
    def destroy
      @product = Product.find(params[:id])
      result = DestroyProduct.call(product: @product)

      if result.success?
        redirect_to admin_products_path,
          notice: 'Product was successfully destroyed.'
      else
        flash[:alert] = result.message
        redirect_to admin_product_path(@product)
      end
    end

    def export
      result = ExportProducts.call(search_terms: params[:search])

      if result.success?
        send_data result.csv_data, filename: result.filename
      else
        redirect_to root_path, alert: result.error
      end
    end


    private

    def authorize_admin
      authorize [:admin, Product]
    end

    def set_product
      @product = Product.find(params[:id])
      @product_view = ProductView.new(@product, current_user: current_user)
    end

    def product_params
      params.require(:product).permit(:title, :price, :description, :status,
        :header_image, images: [])
    end
  end
end
