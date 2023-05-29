class AddDiscountedPriceToCheckout < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :discount_amount, :float
  end
end
