# frozen_string_literal: true

# comtroller for order
module api
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    def index
      @orders = Order.all_orders(current_user)
    end
  end
end
