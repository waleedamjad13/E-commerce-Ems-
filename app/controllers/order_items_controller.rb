class OrderItemsController < ApplicationController
  before_action :set_order_item, except: [:create]
  
  def create
    chosen_product = Product.find(params[:product_id])
    current_cart = @current_cart
  
    if current_cart.products.include?(chosen_product)
      @order_item = current_cart.order_items.find_by(product_id: chosen_product)
      @order_item.quantity += 1
    else
      @order_item = OrderItem.new
      @order_item.cart = current_cart
      @order_item.product = chosen_product
    end

    @order_item.save
    redirect_to cart_path(current_cart)
  end

  def destroy
    @order_item.destroy
    redirect_to cart_path(@current_cart)
  end  

  def add_quantity
    @order_item.quantity += 1
    @order_item.save
    redirect_to cart_path(@current_cart)
  end
  
  def reduce_quantity
    if @order_item.quantity > 1
      @order_item.quantity -= 1
    end
    @order_item.save
    redirect_to cart_path(@current_cart)
  end
  
  private

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id, :cart_id)
    end
end
