# frozen_string_literal: true


module Admin
  # controller for users that are namespaced inside admin
  #
  class CategoriesController < ApplicationController
    before_action :set_category

    def index
      column = params[:column] || 'id' 
      direction = params[:direction] || 'asc'
  
      @categories = Category.order("#{column} #{direction.upcase}")
    end

    def new; end

    def create
      result = CreateCategory.call(category_params: category_params)

      if result.success?
        redirect_to polymorphic_path([:admin, @category]),
          notice: 'Category was successfully created.'
      else
        @category = result.category
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      result = UpdateCategory.call(
        category: @category,
        category_params: category_params
      )

      if result.success?
        redirect_to polymorphic_path([:admin, @category]),
          notice: 'Category was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      result = DestroyCategory.call(category: @category)

      if result.success?
        redirect_to polymorphic_path([:admin, @category]),
          notice: 'Category was successfully deleted.'
      else
        flash[:alert] = result.message
        redirect_to admin_category_path(@category)
      end
    end

    private

    def set_category
      @category = Category.find_by(id: params[:id])
      @category ||= Category.new

      @category_view = CategoryView.new(@category, current_user: current_user)
    end

    def category_params
      params.require(:category).permit(:name, :active)
    end
  end
end
