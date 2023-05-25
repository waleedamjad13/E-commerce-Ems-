# frozen_string_literal: true

# controller for order items
class OrderItemsController < ApplicationController
  before_action :set_order_item

  def update
    result = UpdateOrderItem.call(
      order_item: @order_item,
      add_quantity: params[:add_quantity].present?,
      reduce_quantity: params[:reduce_quantity].present?
    )

    if result.success?
      redirect_to cart_path, notice: 'Order item updated successfully.'
    else
      redirect_to cart_path, alert: result.error
    end
  end

  def destroy
    @order_item.destroy
    redirect_to cart_path
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :cart_id)
  end
end
