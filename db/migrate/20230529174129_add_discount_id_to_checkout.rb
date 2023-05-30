# frozen_string_literal: true

# migration for adding discount_id to checkout
class AddDiscountIdToCheckout < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :discount, foriegn_key: true
  end
end
