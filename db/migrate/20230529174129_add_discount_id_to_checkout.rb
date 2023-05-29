class AddDiscountIdToCheckout < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :discount, foriegn_key: true
  end
end
