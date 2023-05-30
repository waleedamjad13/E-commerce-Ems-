# frozen_string_literal: true

# migration for adding fields to order
class AddAddressToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :address, :text
  end
end
