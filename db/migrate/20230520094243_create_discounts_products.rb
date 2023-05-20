class CreateDiscountsProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts_products do |t|
      t.integer :discount_id
      t.integer :product_id
    end
  end
end
