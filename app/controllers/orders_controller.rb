class OrdersController < ApplicationController
    
  def index
    @orders = Order.all_orders(current_user)
  end
end
